package dev.alessandrodamico.addio_celibrato.services;

import dev.alessandrodamico.addio_celibrato.dtos.CreateQuestionDto;
import dev.alessandrodamico.addio_celibrato.dtos.QuestionDto;
import dev.alessandrodamico.addio_celibrato.entities.Question;
import dev.alessandrodamico.addio_celibrato.repositories.QuestionRepository;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.util.Arrays;
import java.util.Collections;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class QuestionServiceTest {

    @Mock
    private QuestionRepository questionRepository;

    @InjectMocks
    private QuestionService questionService;

    private Question question1;
    private Question question2;
    private CreateQuestionDto createQuestionDto;

    @BeforeEach
    void setUp() {
        question1 = new Question();
        question1.setId(1L);
        question1.setIntro("Intro 1");
        question1.setContent("Test Question 1");
        question1.setCorrectAnswer("Answer 1");
        question1.setIsResolved(false);
        question1.setPosition(1);

        question2 = new Question();
        question2.setId(2L);
        question2.setIntro("Intro 2");
        question2.setContent("Test Question 2");
        question2.setCorrectAnswer("Answer 2");
        question2.setIsResolved(true);
        question2.setPosition(2);

        createQuestionDto = new CreateQuestionDto("New Intro", "New Question", "New Answer");
    }

    @Test
    void add_shouldAssignPositionOne_whenNoQuestionsExist() {
        when(questionRepository.findFirstByOrderByPositionDesc()).thenReturn(Optional.empty());
        when(questionRepository.save(any(Question.class))).thenAnswer(invocation -> {
            Question q = invocation.getArgument(0);
            q.setId(3L);
            return q;
        });

        Long newQuestionId = questionService.add(createQuestionDto);

        assertNotNull(newQuestionId);
        verify(questionRepository, times(1)).findFirstByOrderByPositionDesc();
        verify(questionRepository, times(1)).save(argThat(q -> q.getPosition() == 1 && q.getContent().equals("New Question")));
    }

    @Test
    void add_shouldAssignNextPosition_whenQuestionsExist() {
        when(questionRepository.findFirstByOrderByPositionDesc()).thenReturn(Optional.of(question2));
        when(questionRepository.save(any(Question.class))).thenAnswer(invocation -> {
            Question q = invocation.getArgument(0);
            q.setId(3L);
            return q;
        });

        Long newQuestionId = questionService.add(createQuestionDto);

        assertNotNull(newQuestionId);
        verify(questionRepository, times(1)).findFirstByOrderByPositionDesc();
        verify(questionRepository, times(1)).save(argThat(q -> q.getPosition() == 3 && q.getContent().equals("New Question")));
    }

    @Test
    void updateIsRevolved_shouldUpdateQuestionStatus_whenQuestionExists() {
        when(questionRepository.findById(1L)).thenReturn(Optional.of(question1));
        when(questionRepository.save(any(Question.class))).thenAnswer(invocation -> invocation.getArgument(0));

        QuestionDto updatedQuestionDto = questionService.updateIsRevolved(1L, true);

        assertTrue(updatedQuestionDto.isResolved());
        verify(questionRepository, times(1)).findById(1L);
        verify(questionRepository, times(1)).save(argThat(q -> q.getIsResolved() == true));
    }

    @Test
    void updateIsRevolved_shouldThrowEntityNotFoundException_whenQuestionDoesNotExist() {
        when(questionRepository.findById(anyLong())).thenReturn(Optional.empty());

        assertThrows(EntityNotFoundException.class, () -> questionService.updateIsRevolved(99L, true));
        verify(questionRepository, times(1)).findById(99L);
        verify(questionRepository, never()).save(any(Question.class));
    }

    @Test
    void findFirstPosition_shouldReturnQuestionDto_whenUnresolvedQuestionExists() {
        when(questionRepository.findFirstByIsResolvedIsFalseOrderByPositionAsc()).thenReturn(Optional.of(question1));

        QuestionDto result = questionService.findFirstPosition();

        assertNotNull(result);
        assertEquals(question1.getId(), result.id());
        assertEquals(question1.getContent(), result.content());
        assertFalse(result.isResolved());
        verify(questionRepository, times(1)).findFirstByIsResolvedIsFalseOrderByPositionAsc();
    }

    @Test
    void findFirstPosition_shouldThrowEntityNotFoundException_whenNoUnresolvedQuestionExists() {
        when(questionRepository.findFirstByIsResolvedIsFalseOrderByPositionAsc()).thenReturn(Optional.empty());

        assertThrows(EntityNotFoundException.class, () -> questionService.findFirstPosition());
        verify(questionRepository, times(1)).findFirstByIsResolvedIsFalseOrderByPositionAsc();
    }

    @Test
    void findAll_shouldReturnPageOfQuestionDtos() {
        Pageable pageable = PageRequest.of(0, 10);
        Page<Question> questionPage = new PageImpl<>(Arrays.asList(question1, question2), pageable, 2);

        when(questionRepository.findAll(pageable)).thenReturn(questionPage);

        Page<QuestionDto> resultPage = questionService.findAll(pageable);

        assertNotNull(resultPage);
        assertEquals(2, resultPage.getTotalElements());
        assertEquals(question1.getId(), resultPage.getContent().get(0).id());
        assertEquals(question2.getId(), resultPage.getContent().get(1).id());
        verify(questionRepository, times(1)).findAll(pageable);
    }

    @Test
    void findAll_shouldReturnEmptyPage_whenNoQuestionsExist() {
        Pageable pageable = PageRequest.of(0, 10);
        Page<Question> emptyQuestionPage = new PageImpl<>(Collections.emptyList(), pageable, 0);

        when(questionRepository.findAll(pageable)).thenReturn(emptyQuestionPage);

        Page<QuestionDto> resultPage = questionService.findAll(pageable);

        assertNotNull(resultPage);
        assertTrue(resultPage.isEmpty());
        assertEquals(0, resultPage.getTotalElements());
        verify(questionRepository, times(1)).findAll(pageable);
    }
}

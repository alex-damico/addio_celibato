package dev.alessandrodamico.addio_celibrato.services;

import dev.alessandrodamico.addio_celibrato.dtos.CreateHintDto;
import dev.alessandrodamico.addio_celibrato.dtos.HintDto;
import dev.alessandrodamico.addio_celibrato.entities.Hint;
import dev.alessandrodamico.addio_celibrato.repositories.HintRepository;
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
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class HintServiceTest {

    @Mock
    private HintRepository hintRepository;

    @InjectMocks
    private HintService hintService;

    private Hint hint1;
    private Hint hint2;
    private CreateHintDto createHintDto;
    private final Long QUESTION_ID = 10L;

    @BeforeEach
    void setUp() {
        hint1 = new Hint();
        hint1.setId(1L);
        hint1.setContent("Hint 1");
        hint1.setIsUnlocked(false);
        hint1.setPosition(1);
        hint1.setQuestionId(QUESTION_ID);

        hint2 = new Hint();
        hint2.setId(2L);
        hint2.setContent("Hint 2");
        hint2.setIsUnlocked(true);
        hint2.setPosition(2);
        hint2.setQuestionId(QUESTION_ID);

        createHintDto = new CreateHintDto("New Hint Content", QUESTION_ID);
    }

    @Test
    void add_shouldAssignPositionOne_whenNoHintsExistForQuestion() {
        when(hintRepository.findFirstByQuestionIdOrderByPositionDesc(QUESTION_ID)).thenReturn(Optional.empty());
        when(hintRepository.save(any(Hint.class))).thenAnswer(invocation -> {
            Hint h = invocation.getArgument(0);
            h.setId(3L);
            return h;
        });

        Long newHintId = hintService.add(createHintDto);

        assertNotNull(newHintId);
        verify(hintRepository).findFirstByQuestionIdOrderByPositionDesc(QUESTION_ID);
        verify(hintRepository).save(argThat(h -> h.getPosition() == 1 && h.getQuestionId().equals(QUESTION_ID)));
    }

    @Test
    void add_shouldAssignNextPosition_whenHintsExistForQuestion() {
        when(hintRepository.findFirstByQuestionIdOrderByPositionDesc(QUESTION_ID)).thenReturn(Optional.of(hint2));
        when(hintRepository.save(any(Hint.class))).thenAnswer(invocation -> {
            Hint h = invocation.getArgument(0);
            h.setId(3L);
            return h;
        });

        Long newHintId = hintService.add(createHintDto);

        assertEquals(3L, newHintId);
        verify(hintRepository).save(argThat(h -> h.getPosition() == 3));
    }

    @Test
    void updateIsUnlocked_shouldUpdateStatus_whenHintExists() {
        when(hintRepository.findById(1L)).thenReturn(Optional.of(hint1));
        when(hintRepository.save(any(Hint.class))).thenAnswer(invocation -> invocation.getArgument(0));

        HintDto result = hintService.updateIsUnlocked(1L, true);

        assertTrue(result.isUnlocked());
        verify(hintRepository).save(argThat(h -> h.getIsUnlocked() == true));
    }

    @Test
    void updateIsUnlocked_shouldThrowException_whenHintDoesNotExist() {
        when(hintRepository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(EntityNotFoundException.class, () -> hintService.updateIsUnlocked(99L, true));
    }

    @Test
    void findFirstPosition_shouldReturnHint_whenLockedHintExists() {
        when(hintRepository.findFirstByQuestionIdAndIsUnlockedFalseOrderByPositionAsc(QUESTION_ID))
                .thenReturn(Optional.of(hint1));

        HintDto result = hintService.findFirstPosition(QUESTION_ID);

        assertNotNull(result);
        assertEquals(hint1.getContent(), result.content());
        verify(hintRepository).findFirstByQuestionIdAndIsUnlockedFalseOrderByPositionAsc(QUESTION_ID);
    }

    @Test
    void findAll_shouldReturnPageOfHintsForQuestion() {
        Pageable pageable = PageRequest.of(0, 10);
        Page<Hint> page = new PageImpl<>(Arrays.asList(hint1, hint2), pageable, 2);

        when(hintRepository.findAllByQuestionId(QUESTION_ID, pageable)).thenReturn(page);

        Page<HintDto> result = hintService.findAll(QUESTION_ID, pageable);

        assertEquals(2, result.getTotalElements());
        assertEquals("Hint 1", result.getContent().getFirst().content());
        verify(hintRepository).findAllByQuestionId(QUESTION_ID, pageable);
    }
}

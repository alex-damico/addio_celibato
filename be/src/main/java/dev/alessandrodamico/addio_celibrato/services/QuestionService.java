package dev.alessandrodamico.addio_celibrato.services;

import dev.alessandrodamico.addio_celibrato.dtos.CreateQuestionDto;
import dev.alessandrodamico.addio_celibrato.dtos.QuestionDto;
import dev.alessandrodamico.addio_celibrato.entities.Question;
import dev.alessandrodamico.addio_celibrato.repositories.QuestionRepository;
import jakarta.persistence.EntityExistsException;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class QuestionService {

    private final QuestionRepository repository;

    public QuestionService(QuestionRepository repository) {
        this.repository = repository;
    }

    public Long add(CreateQuestionDto createQuestionDto) {
        Question question = CreateQuestionDto.fromDto(createQuestionDto);
        if (!this.repository.existsByPosition(question.getPosition())) {
            return this.repository.save(question).getId();
        } else {
            throw new EntityExistsException("La posizione " + question.getPosition() + " è già assegnata.");
        }
    }

    public QuestionDto updateIsRevolved(Long id) {
        Question entity = repository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Domanda non trovata"));
        entity.setIsResolved(true);
        return QuestionDto.toDto(repository.save(entity));
    }

    public QuestionDto findFirstPosition() {
        return this.repository.findFirstByIsResolvedIsFalseOrderByPositionAsc().map(QuestionDto::toDto)
                .orElseThrow(EntityNotFoundException::new);
    }

    public Page<QuestionDto> findAll(Pageable pageable) {
        return this.repository.findAll(pageable).map(QuestionDto::toDto);
    }
}

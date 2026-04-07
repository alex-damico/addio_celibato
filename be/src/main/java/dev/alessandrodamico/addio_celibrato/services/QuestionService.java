package dev.alessandrodamico.addio_celibrato.services;

import dev.alessandrodamico.addio_celibrato.dtos.QuestionDto;
import dev.alessandrodamico.addio_celibrato.entities.Question;
import dev.alessandrodamico.addio_celibrato.repositories.QuestionRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class QuestionService {

    private final QuestionRepository repository;

    public QuestionService(QuestionRepository repository) {
        this.repository = repository;
    }

    public void AddQuestion(Question question) {
        this.repository.save(question);
    }

    public QuestionDto findFirstPosition() {
        return this.repository.findFirstByIsResolvedIsFalseOrderByPositionAsc().map(QuestionDto::toDto)
                .orElseThrow(EntityNotFoundException::new);
    }

}

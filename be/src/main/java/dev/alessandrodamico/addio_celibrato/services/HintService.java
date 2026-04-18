package dev.alessandrodamico.addio_celibrato.services;

import dev.alessandrodamico.addio_celibrato.dtos.CreateHintDto;
import dev.alessandrodamico.addio_celibrato.dtos.CreateQuestionDto;
import dev.alessandrodamico.addio_celibrato.dtos.HintDto;
import dev.alessandrodamico.addio_celibrato.dtos.QuestionDto;
import dev.alessandrodamico.addio_celibrato.entities.Hint;
import dev.alessandrodamico.addio_celibrato.entities.Question;
import dev.alessandrodamico.addio_celibrato.repositories.HintRepository;
import dev.alessandrodamico.addio_celibrato.repositories.QuestionRepository;
import jakarta.persistence.EntityExistsException;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class HintService {

    private final HintRepository repository;

    public HintService(HintRepository repository) {
        this.repository = repository;
    }

    public Long add(CreateHintDto createHintDto) {
        Hint hint = CreateHintDto.fromDto(createHintDto);
        if (!this.repository.existsByPosition(hint.getPosition())) {
            return this.repository.save(hint).getId();
        } else {
            throw new EntityExistsException("La posizione " + hint.getPosition() + " è già assegnata.");
        }
    }

    public HintDto updateIsUnlocked(Long id) {
        Hint entity = repository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Domanda non trovata"));
        entity.setIsUnlocked(true);
        return HintDto.toDto(repository.save(entity));
    }

    public HintDto findFirstPosition(Long questionId) {
        return this.repository.findFirstByQuestionIdAndIsUnlockedFalseOrderByPositionAsc(questionId).map(HintDto::toDto)
                .orElseThrow(EntityNotFoundException::new);
    }
}

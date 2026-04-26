package dev.alessandrodamico.addio_celibrato.services;

import dev.alessandrodamico.addio_celibrato.dtos.CreateHintDto;
import dev.alessandrodamico.addio_celibrato.dtos.HintDto;
import dev.alessandrodamico.addio_celibrato.entities.Hint;
import dev.alessandrodamico.addio_celibrato.repositories.HintRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class HintService {

    private final HintRepository repository;

    public HintService(HintRepository repository) {
        this.repository = repository;
    }

    public Long add(CreateHintDto createHintDto) {
        Hint hint = CreateHintDto.fromDto(createHintDto);
        Integer nextPosition = repository.findFirstByQuestionIdOrderByPositionDesc(hint.getQuestionId())
                .map(lastHint -> lastHint.getPosition() + 1)
                .orElse(1);
        hint.setPosition(nextPosition);
        return this.repository.save(hint).getId();
    }

    public HintDto updateIsUnlocked(Long id, Boolean isUnlocked) {
        Hint entity = repository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Suggerimento non trovato"));
        entity.setIsUnlocked(isUnlocked);
        return HintDto.toDto(repository.save(entity));
    }

    public HintDto findFirstPosition(Long questionId) {
        return this.repository.findFirstByQuestionIdAndIsUnlockedFalseOrderByPositionAsc(questionId).map(HintDto::toDto)
                .orElseThrow(EntityNotFoundException::new);
    }

    public Page<HintDto> findAll(Long questionId, Pageable pageable) {
        return this.repository.findAllByQuestionId(questionId, pageable).map(HintDto::toDto);
    }
}

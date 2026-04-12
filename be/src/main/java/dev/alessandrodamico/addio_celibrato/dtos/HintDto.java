package dev.alessandrodamico.addio_celibrato.dtos;

import dev.alessandrodamico.addio_celibrato.entities.Hint;

public record HintDto
        (Long id, Integer position, String content, Boolean isUnlocked, Long questionId)
{
    public static HintDto toDto(Hint entity) {
        return new HintDto(
                entity.getId(),
                entity.getPosition(),
                entity.getContent(),
                entity.getIsUnlocked(),
                entity.getQuestionId()
        );
    }
}



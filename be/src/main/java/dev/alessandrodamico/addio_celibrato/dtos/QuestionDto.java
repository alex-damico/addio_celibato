package dev.alessandrodamico.addio_celibrato.dtos;

import dev.alessandrodamico.addio_celibrato.entities.Question;

public record QuestionDto
        (Long id, Integer position, String intro, String content, String correctAnswer, Boolean isResolved)
{
    public static QuestionDto toDto(Question entity) {
        return new QuestionDto(
                entity.getId(),
                entity.getPosition(),
                entity.getIntro(),
                entity.getContent(),
                entity.getCorrectAnswer(),
                entity.getIsResolved()
        );
    }
}



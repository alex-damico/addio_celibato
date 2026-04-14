package dev.alessandrodamico.addio_celibrato.dtos;

import dev.alessandrodamico.addio_celibrato.entities.Question;

public record CreateQuestionDto
        (Integer position, String intro, String content, String correctAnswer)
{
    public static Question fromDto(CreateQuestionDto dto) {
        return new Question(null, dto.position(), dto.intro(), dto.content(),
                dto.correctAnswer(), false, false);
    }
}



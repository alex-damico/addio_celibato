package dev.alessandrodamico.addio_celibrato.dtos;

import dev.alessandrodamico.addio_celibrato.entities.Question;

public record CreateQuestionDto
        (String intro, String content, String correctAnswer)
{
    public static Question fromDto(CreateQuestionDto dto) {
        return new Question(null, null, dto.intro(), dto.content(),
                dto.correctAnswer(), false, false);
    }
}



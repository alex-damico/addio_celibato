package dev.alessandrodamico.addio_celibrato.dtos;

import dev.alessandrodamico.addio_celibrato.entities.Hint;

public record CreateHintDto
        (String content, Long questionId)
{
    public static Hint fromDto(CreateHintDto dto) {
        return new Hint(null, null, dto.content(), false,
                dto.questionId());
    }
}



package dev.alessandrodamico.addio_celibrato.dtos;

import dev.alessandrodamico.addio_celibrato.entities.Hint;

public record CreateHintDto
        (Integer position, String content, Long questionId)
{
    public static Hint fromDto(CreateHintDto dto) {
        return new Hint(null, dto.position(), dto.content(), false,
                dto.questionId());
    }
}



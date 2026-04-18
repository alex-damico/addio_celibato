package dev.alessandrodamico.addio_celibrato.dtos;

import dev.alessandrodamico.addio_celibrato.entities.Task;

public record TaskDto
        (Long id, String content) {

    public static TaskDto toDto(Task entity) {
        return new TaskDto(
                entity.getId(),
                entity.getContent()
        );
    }
}



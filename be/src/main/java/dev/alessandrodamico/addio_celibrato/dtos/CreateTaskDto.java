package dev.alessandrodamico.addio_celibrato.dtos;

import dev.alessandrodamico.addio_celibrato.entities.Task;

public record CreateTaskDto
        (String content) {
    public static Task fromDto(CreateTaskDto dto) {
        return new Task(null, dto.content());
    }
}



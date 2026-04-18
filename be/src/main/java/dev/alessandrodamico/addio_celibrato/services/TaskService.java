package dev.alessandrodamico.addio_celibrato.services;

import dev.alessandrodamico.addio_celibrato.dtos.CreateTaskDto;
import dev.alessandrodamico.addio_celibrato.dtos.TaskDto;
import dev.alessandrodamico.addio_celibrato.entities.Task;
import dev.alessandrodamico.addio_celibrato.repositories.TaskRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class TaskService {

    private final TaskRepository repository;
    private final TelegramService telegramService;

    public TaskService(TaskRepository repository, TelegramService telegramService) {
        this.repository = repository;
        this.telegramService = telegramService;
    }

    public Long add(CreateTaskDto createTaskDto) {
        Task task = CreateTaskDto.fromDto(createTaskDto);
        return this.repository.save(task).getId();
    }

    public Page<TaskDto> findAll(Pageable pageable) {
        return this.repository.findAll(pageable).map(TaskDto::toDto);
    }

    public Task sendTask(Long id) {
        return this.repository.findById(id).map(
                task -> {
                    this.telegramService.send(task.getContent());
                    return task;
                }
        ).orElseThrow(() -> new EntityNotFoundException("Penitenza non trovata"));
    }
}

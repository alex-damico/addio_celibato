package dev.alessandrodamico.addio_celibrato.services;

import dev.alessandrodamico.addio_celibrato.dtos.CreateTaskDto;
import dev.alessandrodamico.addio_celibrato.dtos.TaskDto;
import dev.alessandrodamico.addio_celibrato.entities.Task;
import dev.alessandrodamico.addio_celibrato.repositories.TaskRepository;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.util.Collections;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class TaskServiceTest {

    @Mock
    private TaskRepository taskRepository;

    @Mock
    private TelegramService telegramService;

    @InjectMocks
    private TaskService taskService;

    private Task task;
    private CreateTaskDto createTaskDto;

    @BeforeEach
    void setUp() {
        task = new Task();
        task.setId(1L);
        task.setContent("Test Task Content");

        createTaskDto = new CreateTaskDto("Test Task Content");
    }

    @Test
    void add_shouldSaveTaskAndReturnId() {
        when(taskRepository.save(any(Task.class))).thenReturn(task);

        Long id = taskService.add(createTaskDto);

        assertEquals(1L, id);
        verify(taskRepository).save(any(Task.class));
    }

    @Test
    void findAll_shouldReturnPageOfTaskDtos() {
        Pageable pageable = PageRequest.of(0, 10);
        Page<Task> taskPage = new PageImpl<>(Collections.singletonList(task), pageable, 1);
        when(taskRepository.findAll(pageable)).thenReturn(taskPage);

        Page<TaskDto> result = taskService.findAll(pageable);

        assertNotNull(result);
        assertEquals(1, result.getTotalElements());
        assertEquals(task.getContent(), result.getContent().getFirst().content());
        verify(taskRepository).findAll(pageable);
    }

    @Test
    void sendTask_shouldSendTelegramMessage_whenTaskExists() {
        when(taskRepository.findById(1L)).thenReturn(Optional.of(task));

        Task result = taskService.sendTask(1L);

        assertNotNull(result);
        assertEquals(task.getContent(), result.getContent());
        verify(telegramService).send(task.getContent());
    }

    @Test
    void sendTask_shouldThrowException_whenTaskDoesNotExist() {
        when(taskRepository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(EntityNotFoundException.class, () -> taskService.sendTask(99L));
        verify(telegramService, never()).send(anyString());
    }
}

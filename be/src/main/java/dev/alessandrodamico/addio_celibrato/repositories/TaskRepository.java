package dev.alessandrodamico.addio_celibrato.repositories;

import dev.alessandrodamico.addio_celibrato.entities.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {

}

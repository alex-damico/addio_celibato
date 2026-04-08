package dev.alessandrodamico.addio_celibrato.repositories;

import dev.alessandrodamico.addio_celibrato.entities.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Long> {

    boolean existsByPosition(Integer position);

    Optional<Question> findFirstByIsResolvedIsFalseOrderByPositionAsc();

}

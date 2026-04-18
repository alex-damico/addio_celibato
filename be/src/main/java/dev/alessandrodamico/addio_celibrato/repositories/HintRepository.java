package dev.alessandrodamico.addio_celibrato.repositories;

import dev.alessandrodamico.addio_celibrato.entities.Hint;
import dev.alessandrodamico.addio_celibrato.entities.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface HintRepository extends JpaRepository<Hint, Long> {

    boolean existsByPosition(Integer position);

    Optional<Hint> findFirstByQuestionIdAndIsUnlockedFalseOrderByPositionAsc(Long questionId);

}

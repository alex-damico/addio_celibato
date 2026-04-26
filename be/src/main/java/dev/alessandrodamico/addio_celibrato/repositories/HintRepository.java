package dev.alessandrodamico.addio_celibrato.repositories;

import dev.alessandrodamico.addio_celibrato.entities.Hint;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface HintRepository extends JpaRepository<Hint, Long> {

    Optional<Hint> findFirstByQuestionIdAndIsUnlockedFalseOrderByPositionAsc(Long questionId);

    Page<Hint> findAllByQuestionId(Long questionId, Pageable pageable);

    Optional<Hint> findFirstByQuestionIdOrderByPositionDesc(Long questionId);
}

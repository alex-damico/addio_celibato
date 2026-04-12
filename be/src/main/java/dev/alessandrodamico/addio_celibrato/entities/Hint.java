package dev.alessandrodamico.addio_celibrato.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "hints")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Hint {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "position", unique = true, nullable = false)
    private Integer position;

    @Column(columnDefinition = "text")
    private String content;

    @Column(name = "is_unlocked", nullable = false)
    private Boolean isUnlocked = false;

    @Column(name = "question_id")
    private Long questionId;

}

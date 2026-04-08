package dev.alessandrodamico.addio_celibrato.entities;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "questions")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "position", unique = true, nullable = false)
    private Integer position;

    @Column(columnDefinition = "text")
    private String content;

    @Column(name = "correct_answer", length = 255)
    private String correctAnswer;

    @Column(name = "is_resolved", nullable = false)
    private Boolean isResolved = false;
}

--liquibase formatted sql
--changeset addio_celibato:001

CREATE TABLE questions
(
    id             BIGSERIAL PRIMARY KEY,
    position       INTEGER      NOT NULL UNIQUE,
    intro          TEXT,
    content        TEXT         NOT NULL,
    correct_answer VARCHAR(255) NOT NULL,
    is_resolved    BOOLEAN      NOT NULL DEFAULT FALSE
);

CREATE TABLE hints
(
    id          BIGSERIAL PRIMARY KEY,
    position    INTEGER NOT NULL UNIQUE,
    content     TEXT    NOT NULL,
    is_unlocked BOOLEAN NOT NULL DEFAULT FALSE,
    question_id BIGINT  NOT NULL,

    CONSTRAINT fk_question FOREIGN KEY (question_id)
        REFERENCES questions (id)
        ON DELETE CASCADE
);
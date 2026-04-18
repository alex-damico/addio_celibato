--liquibase formatted sql
--changeset addio_celibato:001

CREATE TABLE question
(
    id             BIGSERIAL PRIMARY KEY,
    position       INTEGER      NOT NULL UNIQUE,
    intro          TEXT,
    content        TEXT         NOT NULL,
    correct_answer VARCHAR(255) NOT NULL,
    is_resolved    BOOLEAN      NOT NULL DEFAULT FALSE,
    is_last        BOOLEAN               DEFAULT FALSE
);

CREATE
OR REPLACE FUNCTION update_last_row_flag()
RETURNS TRIGGER AS '
BEGIN
    UPDATE question
    SET is_last = FALSE
    WHERE is_last = TRUE;

    NEW.is_last := TRUE;

    RETURN NEW;
END;
' LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_check_last ON question;

CREATE TRIGGER trigger_check_last
    BEFORE INSERT
    ON question
    FOR EACH ROW
    EXECUTE FUNCTION update_last_row_flag();

CREATE INDEX IF NOT EXISTS idx_is_last_true
    ON question (is_last)
    WHERE is_last = TRUE;

CREATE TABLE hint
(
    id          BIGSERIAL PRIMARY KEY,
    position    INTEGER NOT NULL,
    content     TEXT    NOT NULL,
    is_unlocked BOOLEAN NOT NULL DEFAULT FALSE,
    question_id BIGINT  NOT NULL,

    CONSTRAINT fk_question FOREIGN KEY (question_id)
        REFERENCES question (id)
        ON DELETE CASCADE
);


CREATE TABLE task
(
    id      BIGSERIAL PRIMARY KEY,
    content TEXT NOT NULL
);
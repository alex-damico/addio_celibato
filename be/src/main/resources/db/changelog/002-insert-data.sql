--liquibase formatted sql
--changeset addio_celibato:002

INSERT INTO questions (position, intro, content, correct_answer, is_resolved)
VALUES (1, 'Iniziamo con una domanda di riscaldamento.', 'Qual è la capitale d''Italia?', 'Roma', true),
       (2, 'Passiamo alla geografia internazionale.', 'In quale continente si trova il deserto del Sahara?', 'Africa',
        false),
       (3, 'Un po'' di astronomia.', 'Qual è il pianeta più grande del sistema solare?', 'Giove', false),
       (4, NULL, 'Chi ha dipinto la Gioconda?', 'Leonardo da Vinci', false),
       (5, 'Questa è l''ultima domanda della serie.', 'Qual è il simbolo chimico dell''oro?', 'Au', false);
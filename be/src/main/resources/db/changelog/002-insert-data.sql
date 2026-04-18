--liquibase formatted sql
--changeset addio_celibato:002

INSERT INTO question (position, intro, content, correct_answer, is_resolved)
VALUES (1, 'Iniziamo con una domanda di riscaldamento.', 'Qual è la capitale d''Italia?', 'Roma', true),
       (2, 'Passiamo alla geografia internazionale.', 'In quale continente si trova il deserto del Sahara?', 'Africa',
        false),
       (3, 'Un po'' di astronomia.', 'Qual è il pianeta più grande del sistema solare?', 'Giove', false),
       (4, NULL, 'Chi ha dipinto la Gioconda?', 'Leonardo da Vinci', false),
       (5, 'Questa è l''ultima domanda della serie.', 'Qual è il simbolo chimico dell''oro?', 'Au', false);

INSERT INTO hint (position, content, is_unlocked, question_id)
VALUES (1, 'È conosciuta come la Città Eterna.', true, 1),
       (2, 'Ospita al suo interno lo Stato del Vaticano.', false, 1),

       (1, 'È lo stesso continente dove scorre il Nilo.', true, 2),
       (2, 'Si trova a sud dell''Europa, separata dal Mediterraneo.', false, 2),
       (3, 'È la terra dei safari e delle piramidi.', false, 2),

       (1, 'È un gigante gassoso.', true, 3),
       (2, 'Ha una famosa "Grande Macchia Rossa".', false, 3),
       (3, 'Viene dopo Marte nell''ordine dal Sole.', false, 3),

       (1, 'Era un genio del Rinascimento italiano.', true, 4),
       (2, 'Non era solo un pittore, ma anche un inventore e scienziato.', false, 4),
       (3, 'Il suo cognome deriva da una piccola città toscana.', false, 4),

       (1, 'Il nome deriva dal termine latino "Aurum".', true, 5),
       (2, 'È il metallo prezioso per eccellenza.', false, 5);

INSERT INTO task (content)
VALUES ('🎤 *IL CANDIDATO* 🎤' || n'
' || 'Chiedi a 3 sconosciuti un consiglio per un matrimonio felice e registra un video mentre te lo dicono! 📹'),

       ('🍻 *L''ULTIMO BRINDISI* 🍻' || n'
' || 'Trova qualcuno che si chiami come la tua futura sposa e offrile da bere (o fatti offrire un giro!). 🥂'),

       ('👰 *SPOSO MODELLO* 👰' || n'
' ||
        'Fatti scattare una foto con un velo improvvisato (tovaglioli, carta igienica o sacchetti) e inviala nel gruppo! 📸'),

       ('📣 *DICHIARAZIONE PUBBLICA* 📣' || n'
' || 'Sali su una sedia o una panchina e urla: "MI SPOSO E SONO L''UOMO PIÙ FELICE DEL MONDO!" 🌍'),

       ('🎶 *TEST DI SOPRAVVIVENZA* 🎶' || n'
' || 'Convincere un gruppo di sconosciuti a cantare insieme a te un coro da stadio o una canzone strappalacrime! 🎤'),

       ('🕶️ *CAMBIO LOOK* 🕶️' || n'
' ||
        'Indossa un accessorio imbarazzante scelto dai testimoni (boa di piume, occhiali giganti) per i prossimi 30 minuti! 🎭'),

       ('💪 *L''ACROBATA* 💪' || n'
' ||
        'Esegui 10 flessioni in mezzo alla strada; per ogni flessione urla un motivo per cui ami la tua futura moglie! ❤️'),

       ('📱 *SERENATA 2.0* 📱' || n'
' || 'Invia un vocale alla tua fidanzata cantando la vostra canzone... ma con la voce da cartone animato! 🐭'),

       ('🤳 *SELFIE DI GRUPPO* 🤳' || n'
' || 'Fai un selfie con almeno 5 sconosciuti in posa "disperata" per la tua fine imminente! 😱'),

       ('💐 *L''ADDESTRAMENTO* 💐' || n'
' || 'Recupera dei fiori e consegnali alla prima coppia di anziani che incontri augurando loro lunga vita! 👴👵');
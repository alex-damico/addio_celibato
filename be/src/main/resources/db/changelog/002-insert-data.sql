--liquibase formatted sql
--changeset addio_celibato:002

INSERT INTO question (position, intro, content, correct_answer, is_resolved)
VALUES (1, '🧭 Iniziamo da Piazza Barberini (usa la metro).',
        '🧠 Osserva la Fontana del Tritone: quante code di delfino sorreggono la conchiglia?', '4', false),

       (2, '👀 Manca una persona...',
        '📍 Trova Sam 😅', 'Sam', false),

       (3, '🚶 Piazza di Spagna → Trinità dei Monti.',
        '🪜 Conta i gradini della scalinata. Qual è il numero esatto?', '135', false),

       (4, '⛲ Fontana di Trevi (da Piazza di Spagna).',
        '🐎 Osserva le statue laterali: quanti cavalli marini vedi in totale?', '2', false),

       (5, '🏛️ Pantheon.',
        '🏛️ Conta le colonne della facciata principale.', '16', false),

       (6, '🌊 Piazza Navona.',
        '🐍 Nella Fontana dei Quattro Fiumi, quale fiume non guarda la basilica?', 'Nilo', false),

       (7, '👼 Castel Sant''Angelo.',
        '🌉 Sul ponte: quante statue di angeli sono presenti in totale?', '10', false),

       (8, '🇻🇦 Città del Vaticano (opzionale).',
        '👁️ Posizionandoti su un punto preciso della piazza, quante file di colonne vedi?', '1', false),

       (9, '🏠 Torniamo in appartamento',
        '👁️ Ti sei lavato? Sei carico? Ripartiamo?', 'ANDIAMO A MANGIARE', false),

       (10, '🏟️ Colosseo (serale, metro Ottaviano + Termini).',
        '🧱 Quanti archi ci sono al piano terra del Colosseo?', '80', false),

       (11, '🏛️ Fori Imperiali (serale).',
        '📜 Qual è la parola più ricorrente nei pannelli informativi dell''area?', 'Roma', false);

INSERT INTO hint (position, content, is_unlocked, question_id)
VALUES
-- Q1
(1, '🔎 Guarda sotto il Tritone.', false, 1),
(2, '⚖️ Sono simmetriche.', false, 1),
(3, '⬇️ Non sono sopra.', false, 1),
(4, '🌊 Sono creature marine.', false, 1),

-- Q2
(1, '📍 Chi hai trovato?', false, 2),

-- Q3
(1, '⬇️ Parti dal basso.', false, 3),
(2, '🚫 Non saltarne nessuno.', false, 3),
(3, '🔢 Sono più di 120.', false, 3),
(4, '🪜 Devi contarli tutti.', false, 3),

-- Q4
(1, '👀 Guarda ai lati.', false, 4),
(2, '🚫 Non il Tritone centrale.', false, 4),
(3, '🐎 Sono animali marini.', false, 4),
(4, '↔️ Uno per lato.', false, 4),

-- Q5
(1, '🏛️ Solo davanti.', false, 5),
(2, '🚫 Non dentro.', false, 5),
(3, '📏 Sono alte.', false, 5),
(4, '⚖️ Sono simmetriche.', false, 5),
(5, '🔢 Sono 16.', false, 5),

-- Q6
(1, '👀 Guarda le statue.', false, 6),
(2, '🙈 Una è coperta.', false, 6),
(3, '➡️ Non guarda in avanti.', false, 6),
(4, '📚 È un dettaglio storico.', false, 6),
(5, '🌊 È il Nilo.', false, 6),

-- Q7
(1, '↔️ Conta entrambi i lati.', false, 7),
(2, '⚖️ Sono simmetrici.', false, 7),
(3, '5️⃣ per lato.', false, 7),
(4, '⬆️ Guarda sopra il ponte.', false, 7),
(5, '🔢 Sono 10.', false, 7),

-- Q8
(1, '🚶 Devi muoverti.', false, 8),
(2, '🔵 Cerca i dischi a terra.', false, 8),
(3, '🌀 Effetto ottico.', false, 8),
(4, '📐 Le colonne si allineano.', false, 8),
(5, '1️⃣ È una sola fila.', false, 8),

-- Q9
(1, '💪 Fai 10 flessioni davanti al gruppo 🔥', false, 9),
(2, '📸 Fai una storia Instagram per mostrare a tutti quanto sei figo con il vestitino 😎✨', false, 9),
(3, '🕺 Fai 15 secondi di danza improvvisata in mezzo alla piazza 😂', false, 9),
(4, '🤳 Scatta un selfie di gruppo', false, 9),
(5, '🍕 Dai, abbiamo fame… la risposta è "ANDIAMO A MANGIARE" 😂🔥', false, 9),

-- Q10
(1, '🚫 Non contarli tutti.', false, 10),
(2, '📏 Conta una sezione.', false, 10),
(3, '⚖️ È simmetrico.', false, 10),
(4, '✖️ Moltiplica.', false, 10),
(5, '🔢 Sono 80.', false, 10),

-- Q11
(1, '📜 Leggi i cartelli.', false, 11),
(2, '🏷️ È un nome proprio.', false, 11),
(3, '🔁 Compare spesso.', false, 11),
(4, '🏙️ Riguarda la città.', false, 11),
(5, '🇮🇹 È Roma.', false, 11);

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
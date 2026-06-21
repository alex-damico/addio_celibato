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
VALUES
    ('🟢 *5 FLessioni EASY* 💪' || E'\n' || 'Fai 5 flessioni davanti al gruppo 🔥'),
    ('🟢 *SELFIE RANDOM* 📸' || E'\n' || 'Scatta una foto buffa senza pensarci 😄'),
    ('🟢 *DANCE BREAK 10s* 🕺' || E'\n' || 'Fai 10 secondi di ballo improvvisato 😂'),
    ('🟢 *APPLAUSI ROMANI* 👏' || E'\n' || 'Fai 10 applausi forti in piazza'),
    ('🟢 *MODEL WALK* 🚶' || E'\n' || 'Cammina 20 metri come una passerella 😎'),
    ('🟢 *STATUA FRIEND* 🤳' || E'\n' || 'Foto con una statua come fosse un amico'),
    ('🟢 *RISATA VELOCE* 😂' || E'\n' || 'Fai ridere il gruppo entro 20 secondi'),
    ('🟢 *STATUA MODE* 🧍' || E'\n' || 'Resta immobile per 15 secondi'),
    ('🟢 *URLO RANDOM* 📢' || E'\n' || 'Urla “SAM DOVE SEI?”'),
    ('🟢 *SALUTO TURISTI* 👋' || E'\n' || 'Saluta 5 turisti'),
    ('🟢 *FACCIA STRANA* 🎭' || E'\n' || 'Fai una faccia assurda'),
    ('🟢 *POSE RANDOM* 📸' || E'\n' || 'Fai 3 pose strane'),
    ('🟢 *SCATTO* 🏃' || E'\n' || 'Corri sul posto 10 secondi'),
    ('🟢 *VOCE STRANA* 🗣️' || E'\n' || 'Parla con voce buffa'),
    ('🟢 *DITO PUNTATO* 🎯' || E'\n' || 'Indica qualcosa a caso e inventa una spiegazione “intellettuale” seria ma completamente assurda 😄'),
    ('🟢 *SALUTO REALE* 👋' || E'\n' || 'Saluta qualcuno come se fossi un ambasciatore'),
    ('🟢 *VOCE NARRATORE* 🎤' || E'\n' || 'Parla come se stessi narrando un film epico per 30 secondi'),
    ('🟢 *COOL MODE* 😎' || E'\n' || 'Cammina da figo per 20 metri');

INSERT INTO task (content)
VALUES
    ('🟡 *15 FLessioni* 💪' || E'\n' || 'Fai 15 flessioni davanti a tutti 🔥'),
    ('🟡 *STORIA INSTAGRAM* 📸' || E'\n' || 'Fai una storia improvvisata su un oggetto 😎'),
    ('🟡 *INFO ASSURDA* 🗣️' || E'\n' || 'Chiedi qualcosa di ovvio a uno sconosciuto 😂'),
    ('🟡 *GLADIATORE* 🎭' || E'\n' || 'Fai una scena da gladiatore romano'),
    ('🟡 *FALLA RIDERE* 😂' || E'\n' || 'Fai ridere qualcuno entro 30 secondi'),
    ('🟡 *ANNUNCIO* 📢' || E'\n' || 'Urla una frase motivazionale'),
    ('🟡 *DANCE 20s* 🕺' || E'\n' || 'Balla 20 secondi senza musica'),
    ('🟡 *SELFIE STRANO* 📸' || E'\n' || 'Fai selfie con 3 sconosciuti'),
    ('🟡 *ENIGMA* 🧠' || E'\n' || 'Rispondi inventando una storia'),
    ('🟡 *ROMA SPEECH* 🎤' || E'\n' || 'Spiega perché Roma è la migliore'),
    ('🟡 *INTERVISTA* 🗣️' || E'\n' || 'Fai una domanda assurda ad uno sconosciuto'),
    ('🟡 *SCATTO* 🏃' || E'\n' || 'Corri 30 secondi sul posto'),
    ('🟡 *VIDEO STORY* 🤳' || E'\n' || 'Registra una storia parlando di un oggetto inutile'),
    ('🟡 *GUARDA FISSO* 👀' || E'\n' || 'Fissa una ragazza per 30 secondi'),
    ('🟡 *PERSONAGGIO* 🎭' || E'\n' || 'Interpreta un ruolo'),
    ('🟡 *SEGUI GRUPPO* 📍' || E'\n' || 'Segui il gruppo in silenzio per 2 minuti'),
    ('🟡 *RISATA GRUPPO* 😂' || E'\n' || 'Fai ridere tutti'),
    ('🟡 *URLO EPICO* 🎤' || E'\n' || 'Urla una frase epica in piazza'),
    ('🟡 *SALUTA TUTTI* 👋' || E'\n' || 'Saluta chiunque incontri');

INSERT INTO task (content)
VALUES
    ('🔴 *SPOSO IN CRISI* 💍' || E'\n' || 'Fermati in pubblico e dichiara: "sto ancora valutando se sposarmi" con massima serietà 😐'),
    ('🔴 *FOTO ROMANTICA RANDOM* 📸' || E'\n' || 'Chiedi a uno sconosciuto di scattare una foto “romantica da matrimonio” con lo sposo 💍'),
    ('🔴 *DICHIARAZIONE PUBBLICA* 💬' || E'\n' || 'Urla una frase tipo “da oggi non sarò più libero!” in piazza'),
    ('🔴 *PASSERELLA DELLO SPOSO* 🕺' || E'\n' || 'Fai sfilare lo sposo come una celebrità tra i turisti 😎'),
    ('🔴 *FOTO TURISTI A CASO* 📸' || E'\n' || 'Chiedi a un gruppo di turisti una foto ufficiale “addio al celibato italiano”'),
    ('🔴 *INTERVISTA MATRIMONIALE* 🗣️' || E'\n' || 'Chiedi a uno sconosciuto consigli sul matrimonio e registra la risposta'),
    ('🔴 *STORIA INSTAGRAM VERGOGNOSA* 📱' || E'\n' || 'Fai una storia dicendo che lo sposo “non è pronto per questa vita” 😂'),
    ('🔴 *ANNUNCIO TURISTICO FAKE* 📢' || E'\n' || 'Fai un annuncio come guida: “attenzione, passa lo sposo!”'),
    ('🔴 *FOTO IMBARAZZANTE DI GRUPPO* 🤳' || E'\n' || 'Chiedi a uno sconosciuto una foto di gruppo molto seria e formale'),
    ('🔴 *GIURAMENTO PUBBLICO* 🎤' || E'\n' || 'Fai giurare allo sposo una promessa assurda davanti alla piazza'),
    ('🔴 *SIMULAZIONE MATRIMONIO* 💍' || E'\n' || 'Fai una mini cerimonia fake in mezzo alla strada'),
    ('🔴 *URLO COLLETTIVO* 📢' || E'\n' || 'Fai urlare al gruppo “W LO SPOSO!” davanti ai turisti'),
    ('🔴 *SCENA ROMANTICA FAKE* 🎭' || E'\n' || 'Ricrea una scena romantica teatrale con lo sposo'),
    ('🔴 *REPORTER STRADALE* 🗞️' || E'\n' || 'Intervista turisti sullo sposo come fosse una star'),
    ('🔴 *FOTO SERIA ASSURDA* 📸' || E'\n' || 'Chiedi a uno sconosciuto una foto estremamente seria come documento ufficiale'),
    ('🔴 *MISSIONE SILENZIOSA* 🤐' || E'\n' || 'Lo sposo deve camminare serio tra la gente senza ridere per 2 minuti'),
    ('🔴 *INTERVISTA INVASIVA 2.0* 🗣️' || E'\n' || 'Fai una domanda ancora più assurda a uno sconosciuto e insisti per una risposta'),
    ('🔴 *PASSERELLA TRA TURISTI* 🚶' || E'\n' || 'Lo sposo deve attraversare lentamente una zona piena di turisti come una sfilata'),
    ('🔴 *CERIMONIA PUBBLICA FAKE* 💍' || E'\n' || 'Simula una cerimonia completa con pubblico improvvisato'),
    ('🔴 *DICHIARAZIONE D’AMORE FINTA* 💬' || E'\n' || 'Lo sposo deve fare una dichiarazione teatrale a Roma come fosse la sua sposa'),
    ('🔴 *APPLAUSO FORZATO* 👏' || E'\n' || 'Coinvolgi i passanti a fare un applauso allo sposo');
# PDAdmin
link: http://localhost:5050/

# Docker-compose
- Per sviluppo 
    - Avviare ```docker-compose up -d```
    - Stoppare ```docker-compose down```
- Per cloud
    - Avviare ```docker-compose --profile apps up -d```
    - Stoppare ```docker-compose --profile apps down```

# Bot telegram

## Ottenere l'ID della chat di gruppo
Il bot deve sapere dove mandare il messaggio.

- Crea il gruppo e aggiungi il tuo Bot come membro.

- Scrivi un messaggio qualsiasi nel gruppo (es. "Ciao Bot").

- Apri il browser e vai a questo URL (sostituendo il tuo token):
https://api.telegram.org/bot<IL_TUO_TOKEN>/getUpdates

- Cerca nel JSON che appare l'oggetto "chat": {"id": -123456789, ...}.

Nota: Gli ID dei gruppi Telegram iniziano quasi sempre con un segno meno (-). Copia tutto il numero, segno incluso.

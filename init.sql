-- =============================================================================
-- 1. CREAZIONE UTENTE (Se non esiste)
-- =============================================================================
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'addio_celibato_app') THEN
        CREATE ROLE addio_celibato_app WITH LOGIN PASSWORD 'password';
        RAISE NOTICE 'Utente addio_celibato_app creato.';
    ELSE
        RAISE NOTICE 'Utente addio_celibato_app già esistente, salto creazione.';
    END IF;
END
$$;

-- =============================================================================
-- 2. CREAZIONE DATABASE (Se non esiste)
-- =============================================================================
-- Nota: CREATE DATABASE non può stare in un blocco DO. 
-- Usiamo il comando \gexec per eseguire il risultato della query se non nullo.

SELECT 'CREATE DATABASE addio_celibato'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'addio_celibato')\gexec

-- =============================================================================
-- 3. ASSEGNAZIONE PERMESSI
-- =============================================================================
-- Ci connettiamo virtualmente o agiamo sui permessi globali
GRANT ALL PRIVILEGES ON DATABASE addio_celibato TO addio_celibato_app;

-- Se vuoi che l'utente sia il proprietario (Owner) per far girare Liquibase:
ALTER DATABASE addio_celibato OWNER TO addio_celibato_app;

\c addio_celibato
CREATE SCHEMA IF NOT EXISTS app_schema;
GRANT ALL ON SCHEMA app_schema TO addio_celibato_app;
    ALTER ROLE addio_celibato_app SET search_path TO app_schema;


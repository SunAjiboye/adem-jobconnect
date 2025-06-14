-- Create table for job offers
CREATE TABLE IF NOT EXISTS offres (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    postes_declares INTEGER NOT NULL,
    stock_postes_vacants INTEGER NOT NULL
);

-- Create table to track ETL process
CREATE TABLE IF NOT EXISTS etl_run_log (
    run_id SERIAL PRIMARY KEY,
    file_name TEXT NOT NULL,
    file_hash TEXT NOT NULL,
    start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP,
    status TEXT NOT NULL CHECK (status IN ('Success', 'Failed'))
);

#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 <<-EOSQL
    CREATE USER db_user WITH PASSWORD 'db_pass';
    GRANT USAGE ON SCHEMA public TO db_user;
    CREATE DATABASE django;
    GRANT ALL PRIVILEGES ON DATABASE django TO db_user;
    GRANT SELECT ON pg_stat_database TO db_user;
EOSQL

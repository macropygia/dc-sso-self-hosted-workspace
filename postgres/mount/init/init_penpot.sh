#!/bin/bash
set -eu

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE DATABASE penpot TEMPLATE template0 ENCODING 'UTF8' LOCALE '<LOCALE>.utf8';
EOSQL

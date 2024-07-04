#!/bin/sh

# O shell irá encerrar a execução do script quando um comando falhar
set -e

# Aguarda o PostgreSQL iniciar
echo "🔄 Waiting for Postgres Database Startup (${POSTGRES_HOST}:${POSTGRES_PORT}) ..."

while ! nc -z ${POSTGRES_HOST} ${POSTGRES_PORT}; do
  sleep 1
done

echo "✅ Postgres Database Started Successfully (${POSTGRES_HOST}:${POSTGRES_PORT})"

# Verifica a existência dos diretórios
echo "Checking directories..."
ls -l /data/web/
ls -l /data/web/static/
ls -l /data/web/media/

# Aplica as migrações do banco de dados
/venv/bin/python manage.py migrate

# Coleta arquivos estáticos
echo "📦 Collecting static files..."
/venv/bin/python manage.py collectstatic --noinput

# Inicia o servidor Django
/venv/bin/python manage.py runserver 0.0.0.0:8000

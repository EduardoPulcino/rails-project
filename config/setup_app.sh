#!/bin/sh

set -e

DB_HOST="${DB_HOST:-db}"
DB_USER="${POSTGRES_USER:-buffet}"
DB_NAME="${POSTGRES_DB:-app_development}"

echo "-> Waiting for database..."
until pg_isready -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" > /dev/null 2>&1; do
  sleep 1
done

if ! bundle check > /dev/null 2>&1; then
  echo "-> Installing gems..."
  bundle install --jobs 4 --retry 3
fi

if [ -f package.json ] && [ ! -f node_modules/.yarn-integrity ]; then
  echo "-> Installing node packages..."
  yarn install --check-files
fi

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

exec "$@"

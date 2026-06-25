#!/bin/sh

set -e

echo "-> Removing stale server.pid..."
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

echo "-> Running migrations..."
bundle exec rails db:migrate
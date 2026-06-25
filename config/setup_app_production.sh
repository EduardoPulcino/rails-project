#!/bin/sh

set -e

echo "-> PORT is: $PORT"
echo "-> RAILS_ENV is: $RAILS_ENV"

echo "-> Removing stale server.pid..."
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

echo "-> Running migrations..."
bundle exec rails db:migrate
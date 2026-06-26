#!/bin/bash

set -e

echo "-> PORT is: $PORT"
echo "-> RAILS_ENV is: $RAILS_ENV"

echo "-> Removing stale server.pid..."
rm -f tmp/pids/server.pid

echo "-> Running migrations..."
bundle exec rails db:migrate

echo "-> Starting Rails..."
exec bundle exec rails s -p $PORT -b 0.0.0.0
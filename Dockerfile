FROM ruby:3.2.1

ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin \
    GEM_HOME=/usr/local/bundle \
    PATH=/usr/local/bundle/bin:$PATH

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      curl ca-certificates gnupg lsb-release && \
    install -d /usr/share/postgresql-common/pgdg && \
    curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc && \
    echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt bullseye-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      nodejs \
      yarn=1.22.22-1 \
      postgresql-client-14 \
      libpq-dev \
      build-essential \
      git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/app/web

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile || yarn install

COPY . .

RUN chmod +x config/setup_app.sh config/setup_app_production.sh worker/entrypoint.sh

ENV NODE_OPTIONS=--openssl-legacy-provider
RUN SECRET_KEY_BASE=placeholder bundle exec rails assets:precompile

EXPOSE 3000

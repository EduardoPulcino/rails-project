FROM ruby:3.2.1

RUN apt-get update -y && \
    apt-get upgrade -y --fix-missing

RUN apt install lsb-base lsb-release

RUN apt install curl ca-certificates
RUN install -d /usr/share/postgresql-common/pgdg
RUN curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt bullseye-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt update && apt install -y yarn=1.22.22-1

RUN apt install -y \
                   postgresql-client-14 \
                   libpq5 \
                   libpq-dev \
                   vim \
                   postgresql-14

RUN gem install pg

ADD . /home/app/web
WORKDIR /home/app/web

RUN bundle install --jobs 5 --retry 5
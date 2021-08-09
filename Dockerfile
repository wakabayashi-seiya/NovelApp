FROM ruby:2.6.2
ENV DATABASE_HOST db
ENV NODE_ENV development
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs
# build-essentialは、開発に必須のビルドツールを提供しているパッケージ
# libpq-devとpostgresql-clientは、postgreSQLのクライアントで必要なパッケージ
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client
RUN mkdir /academic_app
WORKDIR /academic_app
COPY Gemfile /academic_app/Gemfile
COPY Gemfile.lock /academic_app/Gemfile.lock
RUN bundle install
COPY . /academic_app
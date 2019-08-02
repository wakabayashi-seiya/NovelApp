FROM ruby:2.5.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /academic_app
WORKDIR /academic_app
COPY Gemfile /academic_app/Gemfile
COPY Gemfile.lock /academic_app/Gemfile.lock
RUN bundle install --without production
COPY . /academic_app
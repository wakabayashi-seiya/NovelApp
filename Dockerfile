FROM ruby:2.6.2
ENV DATABASE_HOST db
ENV NODE_ENV development
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client
RUN mkdir /academic_app
WORKDIR /academic_app
COPY Gemfile /academic_app/Gemfile
COPY Gemfile.lock /academic_app/Gemfile.lock
RUN bundle install
COPY . /academic_app
RUN yarn install
RUN RAILS_ENV=test bundle exec rails webpacker:compile
CMD ["rails", "server", "-b", "0.0.0.0"]
FROM ruby:3.0.6

RUN apt-get update -qq && apt-get install -y nodejs default-mysql-client
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

WORKDIR /pigeon

COPY Gemfile /pigeon/Gemfile
COPY Gemfile.lock /pigeon/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /pigeon

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

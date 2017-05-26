FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /guts
WORKDIR /guts
ADD guts.gemspec /guts/guts.gemspec
ADD Gemfile /guts/Gemfile
ADD Gemfile.lock /guts/Gemfile.lock
ADD . /guts
RUN bundle install
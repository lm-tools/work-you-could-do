FROM ruby:2.3.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /work-you-could-do
WORKDIR /work-you-could-do
ADD Gemfile /work-you-could-do/Gemfile
ADD Gemfile.lock /work-you-could-do/Gemfile.lock
RUN bundle install
ADD . /work-you-could-do

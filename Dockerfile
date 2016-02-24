FROM ruby:2.3.0

RUN mkdir -p /srv/app
WORKDIR /srv/app

ADD Gemfile /srv/app/
ADD Gemfile.lock /srv/app/
RUN bundle install

ADD . /srv/app
RUN RAILS_ENV=production bin/rake assets:precompile

EXPOSE 3000

CMD ["bin/unicorn", "-p", "3000", "-c", "config/unicorn.rb"]

ARG version
RUN echo $version > /srv/app/public/version

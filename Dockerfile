FROM ruby:2.3.0

RUN mkdir -p /srv/app
WORKDIR /srv/app

ADD Gemfile /srv/app/
ADD Gemfile.lock /srv/app/
RUN bundle install

ADD . /srv/app

RUN RAILS_ENV=production bin/rake assets:precompile

# Strip out /assets/ from all compiled css, leaving all css-referenced asset paths relative to the
# stylesheets themselves.
# This allows the built Docker image to be used with any RAILS_RELATIVE_URL_ROOT.
RUN for f in $(grep -rl /assets/ public/assets/*.css); \
    do sed -i s#/assets/##g $f && gzip --keep --force $f; done

# setup secrets file
ENV ENV_FILE='./empty.env'
RUN touch empty.env

EXPOSE 80

CMD set -a && . $ENV_FILE && set +a && bin/passenger start -p 80 --max-pool-size 3

ARG version
RUN echo $version > /srv/app/public/version

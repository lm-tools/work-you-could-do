# Work you could do

A tool to help people explore work they could do.

## Prerequisites
- [Ruby] 2.3.0
- [Bundler]
- [PostgreSQL] 9.4

## Installation

Clone the repository:

```sh
$ git clone https://github.com/lm-tools/work-you-could-do.git
```

Make sure that [PostgreSQL] is running, and that your current user (`$ whoami`)
has full access. Alternatively, custom database details can be provided by setting
a `DATABASE_URL` environment variable to a valid [PostgreSQL connection string]

Setup the application:

```sh
$ bin/setup
```

## Run locally in development mode

To start a development-mode web server on `http://localhost:3000`:

```sh
$ bin/rails server
```

## Run tests

To run all tests, and lint [Ruby] code:
```sh
$ bin/test
```

To run [Ruby] linting only:
```sh
$ bin/rubocop
```

To run [RSpec] tests only:
```sh
$ bin/rspec
```

To run [Cucumber] tests only:
```sh
$ bin/cucumber
```

To run tests without VCR (hitting real LMI endpoint):
```
$ VCR_OFF=true bin/test
```

### Database issues during test runs

If you get a `FATAL:  database "work-you-could-do_test" does not exist` error
when running tests, run `$ bin/rake db:test:prepare` to re-setup the test
database.

## Mounting the application in a directory

The app will run mounted at "/" by default. To run within a directory, set the
`RAILS_RELATIVE_URL_ROOT` environment variable.

For example, to mount the application at "/work-you-could-do", run:

```sh
$ RAILS_RELATIVE_URL_ROOT=/work-you-could-do bin/rails server
```

**Note!** [Spring] does not reload the application when environment variables
change, so use this in development with caution.


## Run application on production

Application requires this environment variables to be set:

* `RAILS_RELATIVE_URL_ROOT`, i.e. /work-you-could-do
* `DATABASE_URL`
* `RAILS_ENV = production`
* `RACK_ENV = production`
* `RAILS_DB_POOL_SIZE`, i.e. `2`
* `SECRET_KEY_BASE`
* `GOOGLE_TAG_MANAGER_ID`
* `LMI_SECRET_KEY`
* `LMI_KEY_ID`
* `GOOGLE_SITE_VERIFICATION_ID`

## Run locally in Docker containers

Currently this is intended for validation of the Dockerfile only, developing
via Docker containers is not recommended (particularly on OS X).

### Prerequisites
- [Docker]
- [Docker Compose]
- If using OS X, [Docker Machine]

### Run the application
To start a web server on `http://localhost:3000`:

```sh
$ docker-compose build
$ docker-compose up -d
```

*NOTE:* If using [Docker Machine], then the webserver will be accessible
**from your docker host**, and can be access via its IP address. To get its IP address
run `$ docker-machine ip <name-of-machine>`, then open
`http://<docker-machine ip address>:3000` in a web browser

### Run commands (tests, migrations, etc.) on docker containers

To run commands via docker:

```sh
$ docker-compose run app <command>
```

For example, to run all tests and linting:

```sh
$ docker-compose run app bin/test
```

## Performance tests

For more information go to [performance/README.md][performance/README.md]

[Bundler]: http://bundler.io/
[Ruby]: https://www.ruby-lang.org/
[performance/README.md]: performance/README.md
[PostgreSQL]: http://www.postgresql.org/
[PostgreSQL connection string]: http://www.postgresql.org/docs/9.4/static/libpq-connect.html#AEN41221
[RSpec]: http://rspec.info/
[Cucumber]: https://cucumber.io/
[Docker]: https://www.docker.com/
[Docker Compose]: https://www.docker.com/products/docker-compose
[Docker Machine]: https://www.docker.com/products/docker-machine
[Spring]: https://github.com/rails/spring

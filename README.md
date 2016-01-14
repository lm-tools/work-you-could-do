# work-you-could-do

Work you could do

## Running the application locally

(Please make sure you have Ruby and bundler already installed.)

- `cd ~/dev`
- `git clone https://github.com/lm-tools/work-you-could-do.git`
- `cd work-you-could-do`
- `bundle`
- `git submodule update --init --recursive`

### Run locally

- `rails s`
- Go to `http://localhost:3000`

### Run in Docker containers

- `docker-compose build`
- `docker-compose up -d`
- `docker-machine ip default` will return the IP at which the application is viewable. go to that IP address at port 3000

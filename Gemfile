source "http://rubygems.org"
ruby "2.3.0"

gem "passenger", ">= 5.1.1"
gem "pg"
gem "rails", "~> 5.0", ">= 5.0.1"

gem "httparty"
gem "jbuilder", "~> 2.0"
gem "mail"
gem "silencer", ">= 0.6.0"

gem "govuk_frontend_toolkit", ">= 5.0.2"
gem "govuk_template", ">= 0.19.2"
gem "jquery-rails", ">= 4.2.2"
gem "lograge", ">= 0.6.0"
gem "logstash-event"
gem "logstash-logger"
gem "rake", "< 11.0"
gem "sass-rails", "~> 5.0", ">= 5.0.6"
gem "therubyracer", platforms: :ruby
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", ">= 3.5.2"
end

group :development do
  gem "rubocop"
  gem "spring"
  gem "spring-commands-cucumber"
  gem "spring-commands-rspec"
  gem "web-console", "~> 2.3", ">= 2.3.0"
end

group :test do
  gem "capybara", ">= 2.11.0"
  gem "cucumber-rails", ">= 1.4.5", require: false
  gem "database_cleaner"
  gem "poltergeist", ">= 1.12.0"
  gem "vcr", "~> 3.0"
  gem "webmock"
end

group :production do
  gem "rails_12factor"
end

source "http://rubygems.org"
ruby "2.3.0"

gem "passenger"
gem "pg"
gem "rails", "~> 5.2", ">= 5.2.4.3"

gem "httparty"
gem "jbuilder", "~> 2.6", ">= 2.6.4"
gem "mail"
gem "silencer", ">= 0.6.0"

gem "govuk_frontend_toolkit", ">= 5.0.2"
gem "govuk_template", ">= 0.19.2"
gem "jquery-rails", ">= 4.2.2"
gem "lograge", ">= 0.9.0"
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
  gem "spring", ">= 2.0.0"
  gem "spring-commands-cucumber", ">= 1.0.1"
  gem "spring-commands-rspec", ">= 1.0.4"
  gem "web-console", "~> 2.3", ">= 2.3.0"
end

group :test do
  gem "capybara"
  gem "cucumber-rails", ">= 1.6.0", require: false
  gem "database_cleaner"
  gem "poltergeist"
  gem "vcr", "~> 3.0"
  gem "webmock"
end

group :production do
  gem "rails_12factor"
end

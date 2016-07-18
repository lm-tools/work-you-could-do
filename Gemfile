source "https://rubygems.org"
ruby "2.3.0"

gem "rails", "~> 4.2"
gem "pg"
gem "puma"

gem "health_check"
gem "httparty"
gem "jbuilder", "~> 2.0"
gem "mail"
gem "silencer"

gem "govuk_frontend_toolkit"
gem "govuk_template"
gem "jquery-rails"
gem "sass-rails", "~> 5.0"
gem "therubyracer", platforms: :ruby
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails"
end

group :development do
  gem "rubocop"
  gem "spring"
  gem "spring-commands-cucumber"
  gem "spring-commands-rspec"
  gem "web-console", "~> 2.0"
end

group :test do
  gem "capybara"
  gem "cucumber-rails", require: false
  gem "database_cleaner"
  gem "poltergeist"
  gem "vcr", "~> 3.0"
  gem "webmock"
end

group :production do
  gem "rails_12factor"
end

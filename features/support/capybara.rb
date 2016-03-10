# parse_file returns an array [Rack app, options hash]
Capybara.app = Rack::Builder.parse_file(Rails.root.join("config.ru").to_s).first

if Rails.application.config.relative_url_root.present?
  Rails.application.routes.default_url_options[:script_name] = \
    Rails.application.config.relative_url_root
end

World(Rails.application.routes.url_helpers)

puts "-" * 72
print "Root path for this test run: "
puts Rails.application.routes.url_helpers.root_path
puts "-" * 72

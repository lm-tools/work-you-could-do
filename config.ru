# This file is used by Rack-based servers to start the application.

require ::File.expand_path("../config/environment", __FILE__)
require ::File.expand_path("../lib/middleware/health_check", __FILE__)

# accessible at a consistent location, e.g. for internal load balancer
use HealthCheck

map WorkYouCouldDo::Application.config.relative_url_root || "/" do
  # accessible at the apparent root of the application, e.g. for pingdom
  use HealthCheck

  run Rails.application
end

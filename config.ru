# This file is used by Rack-based servers to start the application.

require ::File.expand_path("../config/environment", __FILE__)
require ::File.expand_path("../lib/middleware/health_check", __FILE__)

use HealthCheck
map WorkYouCouldDo::Application.config.relative_url_root || "/" do
  run Rails.application
end

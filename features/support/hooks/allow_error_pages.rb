Around("@allow-error-pages") do |_scenario, block|
  original = Rails.application
                  .env_config["action_dispatch.show_detailed_exceptions"]
  begin
    Rails.application
         .env_config["action_dispatch.show_detailed_exceptions"] = false

    block.call
  ensure
    Rails.application
         .env_config["action_dispatch.show_detailed_exceptions"] = original
  end
end

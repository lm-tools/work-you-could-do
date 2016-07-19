class HealthCheck
  def initialize(app)
    @app = app
  end

  def call(env)
    return @app.call(env) unless env["PATH_INFO"] == "/health_check"

    database_up? ? success_response : failure_response
  end

  private

  def database_up?
    ActiveRecord::Base.connection.execute("SELECT 1+1 AS result")
  rescue ActiveRecord::ActiveRecordError, PG::Error
    false
  else
    true
  end

  def success_response
    [
      200,
      { "Content-Type" => "application/json" },
      ['{status: "ok", database: "up"}'],
    ]
  end

  def failure_response
    [
      500,
      { "Content-Type" => "application/json" },
      ['{status: "failure", database: "down"}'],
    ]
  end
end

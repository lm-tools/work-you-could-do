class HealthCheck
  def initialize(app)
    @app = app
  end

  def call(env)
    return @app.call(env) unless env["PATH_INFO"] == "/health_check"

    if database_up?
      response(200, { status: "ok", database: "up" })
    else
      response(500, { status: "failure", database: "down" })
    end
  end

  private

  def database_up?
    ActiveRecord::Base.connection.execute("SELECT 1+1 AS result")
  rescue ActiveRecord::ActiveRecordError, PG::Error
    false
  else
    true
  end

  def response(code, json_body)
    [
      code,
      { "Content-Type" => "application/json" },
      [json_body.to_json],
    ]
  end
end

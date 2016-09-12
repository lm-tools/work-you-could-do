import scala.concurrent.duration._

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import io.gatling.jdbc.Predef._

class EwycdSimulation extends Simulation {

  val splitPosition = sys.env("BASE_URL").lastIndexOf("/")
  val baseUrl = sys.env("BASE_URL").substring(0, splitPosition)
  val appPath = sys.env("BASE_URL").substring(splitPosition)

  val httpProtocol = http
    .baseURL(baseUrl)
    .inferHtmlResources(BlackList(""".*\.js""", """.*\.css""", """.*\.gif""", """.*\.jpeg""", """.*\.jpg""", """.*\.ico""", """.*\.woff""", """.*\.(t|o)tf""", """.*\.png"""), WhiteList())
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    .acceptEncodingHeader("gzip, deflate")
    .acceptLanguageHeader("en-GB,en;q=0.5")
    .userAgentHeader("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0")

  val headers_4 = Map(
    "Accept" -> "*/*;q=0.5, text/javascript, application/javascript, application/ecmascript, application/x-ecmascript",
    "Content-Type" -> "application/x-www-form-urlencoded; charset=UTF-8",
    "X-Requested-With" -> "XMLHttpRequest")

  val scn = scenario("EwycdSimulation")
    .exec(http("introduction")
      .get(s"$appPath/deaa1098-46bf-42af-b85d-03909158bc3e/introduction"))
    .pause(1)
    .exec(http("search")
      .get(s"$appPath/deaa1098-46bf-42af-b85d-03909158bc3e/search/new"))
    .pause(1)
    .exec(http("search_with_Retail")
      .get(s"$appPath/deaa1098-46bf-42af-b85d-03909158bc3e/search?query=Retail"))
    .pause(1)
    .exec(http("role_details")
      .get(s"$appPath/deaa1098-46bf-42af-b85d-03909158bc3e/occupations/1254?from_query=Retail")
      .check(css("""input[name="authenticity_token"]""", "value").saveAs("authenticity_token")))
    .pause(1)
    .exec(http("role_details_save")
      .post(s"$appPath/deaa1098-46bf-42af-b85d-03909158bc3e/saved_occupations")
      .headers(headers_4)
      .formParam("utf8", "✓")
      .formParam("authenticity_token", "${authenticity_token}")
      .formParam("soc_code", "1254")
      .formParam("from_query", "Retail"))
    .pause(1)
    .exec(http("role_details")
      .get(s"$appPath/deaa1098-46bf-42af-b85d-03909158bc3e/occupations/1254?from_query=Retail")
      .check(css("""input[name="authenticity_token"]""", "value").saveAs("authenticity_token")))
    .pause(1)
    .exec(http("delete_role")
      .post(s"$appPath/deaa1098-46bf-42af-b85d-03909158bc3e/saved_occupations/1254")
      .headers(headers_4)
      .formParam("utf8", "✓")
      .formParam("_method", "DELETE")
      .formParam("authenticity_token", "${authenticity_token}"))


  setUp(scn.inject(rampUsers(10) over (2 seconds))).protocols(httpProtocol)
}

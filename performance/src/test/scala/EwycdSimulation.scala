import scala.concurrent.duration._

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import io.gatling.jdbc.Predef._

class EwycdSimulation extends Simulation {

  val splitPosition = sys.env("BASE_URL").lastIndexOf("/")
  val baseUrl = sys.env("BASE_URL").substring(0, splitPosition)
  val appPath = sys.env("BASE_URL").substring(splitPosition)
  val users = sys.env("USERS").toInt
  val time = sys.env("RAMP_UP_TIME").toInt

  val httpProtocol = http
    .baseURL(baseUrl)
    .inferHtmlResources(BlackList(""".*\.js""", """.*\.css""", """.*\.gif""", """.*\.jpeg""", """.*\.jpg""", """.*\.ico""", """.*\.woff""", """.*\.(t|o)tf""", """.*\.png"""), WhiteList())
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    .acceptEncodingHeader("gzip, deflate")
    .acceptLanguageHeader("en-GB,en;q=0.5")
    .userAgentHeader("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0")

  val postHeaders = Map(
    "Accept" -> "*/*;q=0.5, text/javascript, application/javascript, application/ecmascript, application/x-ecmascript",
    "Content-Type" -> "application/x-www-form-urlencoded; charset=UTF-8",
    "X-Requested-With" -> "XMLHttpRequest")

  val refIdFeeder = Iterator.continually(Map("refId" -> java.util.UUID.randomUUID.toString))
  val searchTerm = "Retail"
  val searchCode = "1254"

  val scn = scenario("EwycdSimulation")
    .feed(refIdFeeder)
    .exec(http("introduction")
      .get(s"$appPath/$${refId}/introduction"))
    .pause(2)
    .exec(http("search")
      .get(s"$appPath/$${refId}/search/new"))
    .pause(2)
    .exec(http("search_with_query")
      .get(s"$appPath/$${refId}/search?query=${searchTerm}"))
    .pause(2)
    .exec(http("role_details")
      .get(s"$appPath/$${refId}/occupations/${searchCode}?from_query=${searchTerm}")
      .check(css("""input[name="authenticity_token"]""", "value").saveAs("authenticity_token")))
    .pause(2)
    .exec(http("role_details_save")
      .post(s"$appPath/$${refId}/saved_occupations")
      .headers(postHeaders)
      .formParam("utf8", "✓")
      .formParam("authenticity_token", "${authenticity_token}")
      .formParam("soc_code", searchCode)
      .formParam("from_query", searchTerm))
    .pause(2)
    .exec(http("role_details")
      .get(s"$appPath/$${refId}/occupations/${searchCode}?from_query=${searchTerm}")
      .check(css("""input[name="authenticity_token"]""", "value").saveAs("authenticity_token")))
    .pause(2)
    .exec(http("delete_role")
      .post(s"$appPath/$${refId}/saved_occupations/${searchCode}")
      .headers(postHeaders)
      .formParam("utf8", "✓")
      .formParam("_method", "DELETE")
      .formParam("authenticity_token", "${authenticity_token}"))


  setUp(scn.inject(rampUsers(users) over (time seconds))).protocols(httpProtocol)
}

require "base64"

class LmiClient
  include HTTParty
  base_uri "http://api.lmiforall.org.uk/api/v1"

  def initialize
    @secret_key = Rails.application.secrets.lmi_secret_key
    @key_id = Rails.application.secrets.lmi_key_id
  end

  def soc_search(keyword)
    Rails.logger.info("lmi4all soc_search")
    response = self.class.get(
      "/soc/search",
      query: { q: keyword },
      headers: generate_hmac_headers
    )
    response.success? ? response : []
  end

  def hours_lookup(soc_code)
    Rails.logger.info("lmi4all estimateHours")
    self.class.get(
      "/ashe/estimateHours?soc=#{soc_code}&coarse=true",
      headers: generate_hmac_headers
    )
  end

  def pay_lookup(soc_code)
    Rails.logger.info("lmi4all estimatePay")
    self.class.get(
      "/ashe/estimatePay?soc=#{soc_code}&coarse=true",
      headers: generate_hmac_headers
    )
  end

  def soc_code_lookup(soc_code)
    Rails.logger.info("lmi4all soc/code")
    self.class.get(
      "/soc/code/#{soc_code}",
      headers: generate_hmac_headers
    )
  end

  def generate_hmac_headers
    httpdate = DateTime.now.in_time_zone.httpdate
    hmac = Base64.encode64(OpenSSL::HMAC.digest("sha1", @secret_key, httpdate))
                 .split.join
    {
      "Authorization":
        "Signature keyId=\"#{@key_id}\","\
        "algorithm=\"hmac-sha1\","\
        "signature=\"#{hmac}\"",
      "Date": httpdate,
    }
  end
end

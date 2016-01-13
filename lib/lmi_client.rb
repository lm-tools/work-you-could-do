class LmiClient

  BASE_URL = "http://api.lmiforall.org.uk/api/v1/"

  def occupation_search(keyword)
    HTTParty.get(BASE_URL+"soc/search", { query: {q: keyword} })
  end

  def hours_lookup(soc_code)
    request(
      "ashe/estimateHours?soc=#{soc_code}&coarse=true"
    )["series"][0]["hours"]
  end

  def pay_lookup(soc_code)
    request(
      "ashe/estimatePay?soc=#{soc_code}&coarse=true"
    )["series"][0]["estpay"]
  end

  def soc_code_lookup(soc_code)
    request(
      "soc/code/#{soc_code}"
    )
  end

  private

  def request(path)
    HTTParty.get(BASE_URL+path)
  end

end

class LmiClient

  BASE_URL = "http://api.lmiforall.org.uk/api/v1/"

  def occupation_search(keyword)
    request(BASE_URL+"soc/search?q=#{keyword}")
  end

  def hours_lookup(soc_code)
    request(
      BASE_URL+"ashe/estimateHours?soc=#{soc_code}&coarse=true"
    )[:series][0][:hours]
  end

  def pay_lookup(soc_code)
    request(
      BASE_URL+"ashe/estimatePay?soc=#{soc_code}&coarse=true"
    )[:series][0][:estpay]
  end

  def soc_code_lookup(soc_code)
    request(
      BASE_URL+"soc/code/#{soc_code}"
    )
  end

  private

  def request(path)
    HTTParty.get(BASE_URL+path).symbolize_keys
  end

end

class LmiClient
  include HTTParty
  base_uri "api.lmiforall.org.uk/api/v1"

  def soc_search(keyword)
    self.class.get("/soc/search", query: { q: keyword })
  end

  def hours_lookup(soc_code)
    self.class.get(
      "/ashe/estimateHours?soc=#{soc_code}&coarse=true"
    )["series"][0]["hours"]
  end

  def pay_lookup(soc_code)
    self.class.get(
      "/ashe/estimatePay?soc=#{soc_code}&coarse=true"
    )["series"][0]["estpay"]
  end

  def soc_code_lookup(soc_code)
    self.class.get(
      "/soc/code/#{soc_code}"
    )
  end
end

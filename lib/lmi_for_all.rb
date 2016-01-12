class LmiForAll
  def initialize(soc_code)
    @soc_code = soc_code
  end

  def lookup
    lmi_occupation = lmi_request("soc/code/#{@soc_code}")
    {
      soc_code: @soc_code,
      title: friendly_soc_title(lmi_occupation["title"]),
      description: friendly_soc_description(lmi_occupation["description"]),
      tasks: lmi_occupation["tasks"],
      qualifications: lmi_occupation["qualifications"],
      additional_titles: clean_add_titles(lmi_occupation["add_titles"]),
      week_hours: week_hours,
      week_pay: week_pay
    }
  end

  private

  def lmi_request(path, params = {})
    base_url = "http://api.lmiforall.org.uk/api/v1/"
    HTTParty.get(base_url+path)
  end

  def week_hours
    lmi_request(
      "ashe/estimateHours?soc=#{@soc_code}&coarse=true"
    )["series"][0]["hours"]
  end

  def week_pay
    lmi_request(
      "ashe/estimatePay?soc=#{@soc_code}&coarse=true"
    )["series"][0]["estpay"]
  end

  def friendly_soc_title(title)
    heading_re = /n\.e\.c\.\s*$/
    title.gsub(heading_re, '').strip
  end

  def friendly_soc_description(description)
    description_re = /not elsewhere classified in .*\.$/
    description.gsub(description_re, '')
  end

  def clean_add_titles(titles)
    formattable_titles = titles.select do |title|
      title.length >= 4 && !title.include?("(")
    end[0..19]
    formattable_titles.map do |formattable_title|
      if formattable_title.include?(",")
        a, b = formattable_title.split(",", 1)
        formattable_title = "#{b} #{a}"
      end
      formattable_title.strip.titleize
    end.join(", ")
  end
end

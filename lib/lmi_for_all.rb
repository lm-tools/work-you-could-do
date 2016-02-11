class LmiForAll
  def initialize(lmi_client)
    @lmi_client = lmi_client
  end

  def lookup(soc_code)
    lmi_occupation = @lmi_client.soc_code_lookup(soc_code)
    {
      soc_code: soc_code,
      week_hours: @lmi_client.hours_lookup(soc_code),
      week_pay: @lmi_client.pay_lookup(soc_code),
    }.merge(formatted_lmi_occupation(lmi_occupation))
  end

  private

  def formatted_lmi_occupation(lmi_occupation)
    {
      title: friendly_soc_title(lmi_occupation["title"]),
      description: friendly_soc_description(lmi_occupation["description"]),
      tasks: lmi_occupation["tasks"],
      qualifications: lmi_occupation["qualifications"],
      additional_titles: clean_add_titles(lmi_occupation["add_titles"]),
    }
  end

  def friendly_soc_title(title)
    heading_re = /n\.e\.c\.\s*$/
    title.gsub(heading_re, "").strip
  end

  def friendly_soc_description(description)
    description_re = / not elsewhere classified in .*/
    description.gsub(description_re, "")
  end

  def clean_add_titles(titles)
    formattable_titles = titles.select do |title|
      title.length >= 4 && !title.include?("(")
    end[0..19]
    formattable_titles.map do |formattable_title|
      if formattable_title.include?(",")
        a, b = formattable_title.split(",", 2)
        formattable_title = "#{b} #{a}"
      end
      formattable_title.strip.titleize
    end.join("; ")
  end
end

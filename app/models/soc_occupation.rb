class SocOccupation < ActiveRecord::Base
  has_many :occupations

  def self.find_or_import_from_lmi(soc_code)
    soc_url = "http://api.lmiforall.org.uk/api/v1/soc/code/#{soc_code}"
    lmi_occupation = HTTParty.get(soc_url)
    self.create(
      title: lmi_occupation["title"],
      description: lmi_occupation["description"],
      tasks: lmi_occupation["tasks"],
      qualifications: lmi_occupation["qualifications"],
      additional_titles: clean_add_titles(lmi_occupation["add_titles"]),
      week_hours: 999, #TODO,
      week_pay: 999 #TODO
    )
  end

  private

  def self.clean_add_titles(titles)
    formattable_titles = titles.select do |title|
      title.length >= 4 && !title.include?("(")
    end
    formattable_titles.map do |formattable_title|
      if formattable_title.include?(",")
        a, b = formattable_title.split(",", 1)
        formattable_title = "#{b} #{a}"
      end
      formattable_title.strip.capitalize
    end.join("; ")
  end

end

class SocOccupation < ActiveRecord::Base
  has_many :occupations

  def self.find_or_import_from_lmi(soc_code)
    begin
      self.find_by_soc_code(soc_code)
    rescue RecordNotFound
      soc_url = "http://api.lmiforall.org.uk/api/v1/soc/code/#{soc_code}"
      lmi_occupation = HTTParty.get(soc_url)
      self.create(
        title: friendly_soc_title(lmi_occupation["title"]),
        description: friendly_soc_description(lmi_occupation["description"]),
        tasks: lmi_occupation["tasks"],
        qualifications: lmi_occupation["qualifications"],
        additional_titles: clean_add_titles(lmi_occupation["add_titles"]),
        week_hours: 999, #TODO,
        week_pay: 999 #TODO
      )
    end
  end

  private

  def self.friendly_soc_title(title)
    heading_re = /n\.e\.c\.\s*$/
    title.gsub(heading_re, '').strip
  end

  def self.friendly_soc_description(description)
    description_re = /not elsewhere classified in .*\.$/
    description.gsub(description_re, '')
  end

  def self.clean_add_titles(titles)
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

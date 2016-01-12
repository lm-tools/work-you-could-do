class Keyword < ActiveRecord::Base
  has_many :occupations

  def add_new_occupations
    search_url = "http://api.lmiforall.org.uk/api/v1/soc/search"
    lmi_occupations = HTTParty.get(search_url, { query: {q: self.keyword} })[0..4]
    soc_codes = lmi_occupations.map do |lmi_occupation|
      lmi_occupation["soc"]
    end
    occupations = soc_codes.map do |soc_code|
      soc_url = "http://api.lmiforall.org.uk/api/v1/soc/code/#{soc_code}"
      lmi_occupation = HTTParty.get(soc_url)
      # TODO: qualifications, tasks, add_titles
      Occupation.new(
        soc_code: soc_code,
        title: lmi_occupation["title"],
        description: lmi_occupation["description"]
      )
    end
    self.occupations = occupations
    self
  end
end

class Keyword < ActiveRecord::Base
  has_many :occupations

  def add_new_occupations
    search_url = "http://api.lmiforall.org.uk/api/v1/soc/search"
    lmi_occupations = HTTParty.get(search_url, { query: {q: self.keyword} })[0..4]
    soc_codes = lmi_occupations.map do |lmi_occupation|
      lmi_occupation["soc"]
    end
    occupations = soc_codes.map do |soc_code|
      soc_occupation = SocOccupation.find_or_import_from_lmi(soc_code)
      Occupation.new(
        soc_occupation: soc_occupation,
      )
    end
    self.occupations = occupations
    self
  end
end

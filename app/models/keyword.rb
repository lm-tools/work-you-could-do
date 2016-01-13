require 'lmi_client'

class Keyword < ActiveRecord::Base
  has_many :occupations

  def add_new_occupations
    occupations = soc_codes.map do |soc_code|
      soc_occupation = SocOccupation.find_or_import_from_lmi(soc_code)
      Occupation.new(
        soc_occupation: soc_occupation
      )
    end
    self.occupations = occupations
    self
  end

  def soc_codes
    lmi_client = LmiClient.new
    lmi_occupations = lmi_client.occupation_search(keyword)[0..4]
    lmi_occupations.map do |lmi_occupation|
      lmi_occupation['soc']
    end
  end
end

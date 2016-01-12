require 'active_record/errors'
require 'lmi_for_all'

class SocOccupation < ActiveRecord::Base
  has_many :occupations

  def self.find_or_import_from_lmi(soc_code)
    soc_occupation_lookup = self.where(soc_code: soc_code)
    if soc_occupation_lookup.empty?
      soc_occupation_lookup = LmiForAll.new(soc_code).lookup
      soc_occupation = self.create(soc_occupation_lookup)
    else
      soc_occupation_lookup.first
    end
  end
end
class Occupation < ActiveRecord::Base
  def self.find_or_import_from_lmi(soc_code)
    where(soc_code: soc_code).first_or_create do |soc_occupation|
      lmi_client = LmiClient.new
      soc_occupation_lookup = LmiForAll.new(lmi_client).lookup(soc_code)
      soc_occupation.assign_attributes(soc_occupation_lookup)
    end
  end

  def to_param
    soc_code.to_s
  end
end

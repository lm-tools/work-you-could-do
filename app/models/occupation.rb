class Occupation < ActiveRecord::Base
  def to_hash
    {
      "title": title,
      "description": description,
      "soc_code": soc_code
    }
  end
end

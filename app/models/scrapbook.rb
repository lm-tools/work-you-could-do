class Scrapbook < ActiveRecord::Base
  VALID_ID = \
    /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/i

  def self.new_id
    SecureRandom.uuid
  end

  has_and_belongs_to_many :occupations, join_table: "saved_occupations"
end

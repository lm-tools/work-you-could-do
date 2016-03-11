class Scrapbook < ActiveRecord::Base
  VALID_ID = \
    /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/i

  def self.new_id
    SecureRandom.uuid
  end

  has_many :saved_occupations, -> { order(:updated_at) }
  has_many :occupations, through: :saved_occupations
  has_many :search_log_entries
end

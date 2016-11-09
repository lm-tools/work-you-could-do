require "csv"

class Scrapbook < ActiveRecord::Base
  VALID_ID = \
    /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/i

  def self.new_id
    SecureRandom.uuid
  end

  def self.metrics
    output = CSV.generate(headers: true) do |csv|
      csv << %w(interventionRef totalSavedRoles)

      Scrapbook.all.find_each do |scrapbook|
        csv << [scrapbook.id, scrapbook.occupations.count]
      end
    end
    output
  end

  has_many :saved_occupations, -> { order(:updated_at) }
  has_many :occupations, through: :saved_occupations
  has_many :search_log_entries
end

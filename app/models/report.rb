class Report < ActiveRecord::Base
  extend FriendlyId
  friendly_id :guid
  has_many :keywords
  has_many :occupations, through: :keywords

  def self.generate_report_for_keywords(search_keywords)
    keywords = search_keywords.map do |search_keyword|
      keyword = Keyword.new(keyword: search_keyword)
      keyword.add_new_occupations
    end
    Report.create(
      keywords: keywords,
      guid: SecureRandom.hex(10)
    )
  end

  def mark_occupations_as_selected(occupation_ids)
    occupations.where(id: occupation_ids).select do |occupation|
      occupation.selected = true
      occupation.save
    end
  end

  def selected_occupations
    occupations.where(selected: true)
  end
end

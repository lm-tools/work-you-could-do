class Report < ActiveRecord::Base
  extend FriendlyId
  friendly_id :guid
  has_many :keywords
  has_many :occupations, through: :keywords

  validates :keywords, length: { minimum: 1 }

  def self.generate_report_for_keywords(search_keywords)
    keywords = search_keywords.reject(&:empty?).map do |search_keyword|
      keyword = Keyword.new(keyword: search_keyword)
      keyword.add_new_occupations
    end
    Report.new(
      keywords: keywords,
      guid: SecureRandom.hex(10)
    )
  end

  def find_occupation(occupation_id)
    occupations.find { |o| o.id == occupation_id }
  end

  def mark_occupations_as_selected(occupation_ids)
    occupations.map do |occupation|
      is_selected = occupation_ids.include?(occupation.id)
      occupation.update_attributes(
        selected: is_selected,
        accepted: is_selected ? nil : false
      )
    end
    !occupation_ids.empty?
  end

  def occupations_to_review
    occupations.to_a.select{ |o| o.selected }
                    .uniq{ |o| o.soc_occupation_id }
                    .select { |o| o.accepted == nil }
  end

  def occupations_to_review?
    occupations_to_review.count > 0
  end

  def accepted_occupations
    occupations.select{ |o| o.accepted }
  end

  def selected_occupations
    occupations.select{ |o| o.selected }
  end

  def complete?
    selected_occupations.count > 0 && !occupations_to_review?
  end
end

class Report < ActiveRecord::Base
  extend FriendlyId
  friendly_id :guid
  has_many :keywords
  has_many :occupations, through: :keywords
  has_many :actions, through: :occupations

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

  def find_occupation(occupation_id)
    occupations.find { |o| o.id == occupation_id }
  end

  def mark_occupations_as_selected(occupation_ids)
    occupations.where(id: occupation_ids).select do |occupation|
      occupation.selected = true
      occupation.save
    end
    occupations.where.not(id: occupation_ids).select do |occupation|
      occupation.selected = false
      occupation.accepted = false
      occupation.save
    end
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

  def unique_actions
    actions.to_a.uniq{ |a| a.action_type }
  end

  def accepted_occupations_for_action_type(action_type)
    result = accepted_occupations.select do |o|
      o.actions.map(&:action_type).include?(action_type)
    end
  end
end

class Occupation < ActiveRecord::Base
  belongs_to :soc_occupation
  delegate :title,
           :description,
           :week_pay,
           :week_hours,
           :tasks,
           :qualifications,
           :additional_titles,
           to: :soc_occupation
  has_many :actions

  def formatted_tasks
    tasks.split(';').map(&:strip).map(&:capitalize)
  end

  def mark_as_refused
    self.accepted = false
    self.save!
  end

  def mark_as_accepted_with_actions(params)
    self.accepted = true
    self.actions = params["actions"].keys.map do |action_key|
      action = Action.new(action_type: action_key[1..-1])
      if action_key == ":notes"
        action.notes = params["notes"]
      end
      action
    end
    self.save!
  end
end

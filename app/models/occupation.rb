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

  def action_by_type(action_type)
    actions.where(action_type: action_type).first
  end

  def mark_as_refused
    update(accepted: false)
  end

  def mark_as_accepted_with_actions(params)
    self.accepted = true
    self.actions = params[:actions].keys.map do |action_key|
      action = Action.new(action_type: action_key)
      action.notes = params[:notes] if action_key == 'notes'
      action
    end
    save!
  end
end

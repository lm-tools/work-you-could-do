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

  def update_with_actions(occupation_params, action_params)
    actions = action_params.map do |action_key|
      Action.new(action_type: action_key)
    end
    params = occupation_params.merge(
      actions: actions
    )
    update(params)
  end
end

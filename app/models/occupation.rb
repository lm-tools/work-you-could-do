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

  def formatted_tasks
    tasks.split(";").map(&:strip).map(&:capitalize)
  end

end

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
end

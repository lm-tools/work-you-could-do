class Report < ActiveRecord::Base
  has_many :keywords
  has_many :occupations, through: :keywords
end

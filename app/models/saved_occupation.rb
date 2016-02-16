class SavedOccupation < ActiveRecord::Base
  belongs_to :occupation
  belongs_to :scrapbook
end

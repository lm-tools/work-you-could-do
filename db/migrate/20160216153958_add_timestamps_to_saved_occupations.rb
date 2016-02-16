class AddTimestampsToSavedOccupations < ActiveRecord::Migration
  def change
    add_timestamps(:saved_occupations)
  end
end

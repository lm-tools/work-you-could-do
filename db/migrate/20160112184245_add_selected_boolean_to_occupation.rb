class AddSelectedBooleanToOccupation < ActiveRecord::Migration
  def change
    add_column :occupations, :selected, :boolean
  end
end

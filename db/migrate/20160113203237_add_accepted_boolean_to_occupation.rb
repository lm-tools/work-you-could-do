class AddAcceptedBooleanToOccupation < ActiveRecord::Migration
  def change
    add_column :occupations, :accepted, :boolean
  end
end

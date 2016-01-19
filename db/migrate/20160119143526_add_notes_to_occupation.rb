class AddNotesToOccupation < ActiveRecord::Migration
  def change
    add_column :occupations, :notes, :text
  end
end

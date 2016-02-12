class AddSocCodeIndexToOccupations < ActiveRecord::Migration
  def change
    add_index :occupations, :soc_code, unique: true
  end
end

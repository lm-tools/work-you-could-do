class RenameSocOccupationsToOccupations < ActiveRecord::Migration
  def change
    rename_table :soc_occupations, :occupations
  end
end

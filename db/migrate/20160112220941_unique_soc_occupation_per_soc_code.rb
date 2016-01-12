class UniqueSocOccupationPerSocCode < ActiveRecord::Migration
  def change
    remove_index :soc_occupations, :soc_code
    add_index :soc_occupations, :soc_code, :unique => true
  end
end

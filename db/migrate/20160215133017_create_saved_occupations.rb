class CreateSavedOccupations < ActiveRecord::Migration
  def change
    create_table :saved_occupations, id: false do |t|
      t.integer :occupation_id
      t.integer :scrapbook_id
    end

    add_index :saved_occupations, :occupation_id
    add_index :saved_occupations, :scrapbook_id
    add_index :saved_occupations, [:occupation_id, :scrapbook_id], unique: true
  end
end

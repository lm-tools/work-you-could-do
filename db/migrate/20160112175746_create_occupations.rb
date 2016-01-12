class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
      t.belongs_to :keyword, index: true
      t.integer :soc_code
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end

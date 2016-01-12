class CreateSocOccupations < ActiveRecord::Migration
  def change
    create_table :soc_occupations do |t|
      t.integer :soc_code, index: true
      t.string :title
      t.text :description
      t.text :tasks
      t.text :qualifications
      t.text :additional_titles
      t.integer :week_hours
      t.integer :week_pay
      t.timestamps null: false
    end
    add_column :occupations, :soc_occupation_id, :integer, index: true
  end
end

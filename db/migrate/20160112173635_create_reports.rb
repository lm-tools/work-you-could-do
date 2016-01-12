class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :guid, unique: true

      t.timestamps null: false
    end
    create_table :keywords do |t|
      t.belongs_to :report, index: true
      t.string :keyword

      t.timestamps null: false
    end
    create_table :occupations do |t|
      t.belongs_to :keyword, index: true
      t.boolean :selected
      t.integer :soc_occupation_id, index: true

      t.timestamps null: false
    end
    create_table :soc_occupations do |t|
      t.integer :soc_code, unique: true
      t.string :title
      t.text :description
      t.text :tasks
      t.text :qualifications
      t.text :additional_titles
      t.integer :week_hours
      t.integer :week_pay

      t.timestamps null: false
    end
  end
end

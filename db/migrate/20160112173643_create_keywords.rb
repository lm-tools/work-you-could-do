class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.belongs_to :report, index: true
      t.string :keyword

      t.timestamps null: false
    end
  end
end

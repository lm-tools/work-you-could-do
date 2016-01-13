class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.belongs_to :occupation, index: true
      t.string :action_type

      t.timestamps null: false
    end
  end
end

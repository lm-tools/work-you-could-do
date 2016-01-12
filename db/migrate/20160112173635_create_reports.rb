class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|

      t.timestamps null: false
    end
  end
end

class CreateScrapbooks < ActiveRecord::Migration
  def change
    create_table :scrapbooks, id: :uuid do |t|
      t.timestamps
    end
  end
end

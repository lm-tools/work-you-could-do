class CreateSearchLogEntries < ActiveRecord::Migration
  def change
    create_table :search_log_entries do |t|
      t.references :scrapbook
      t.text :query
      t.timestamps
    end
  end
end

class AddKeywordToReport < ActiveRecord::Migration
  def change
    add_column :reports, :keyword, :text
  end
end

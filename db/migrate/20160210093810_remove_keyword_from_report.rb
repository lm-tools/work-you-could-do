class RemoveKeywordFromReport < ActiveRecord::Migration
  def change
    remove_column :reports, :keyword, :Keyword
  end
end

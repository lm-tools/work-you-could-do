class RemoveActionsOccupationsKeywordsReports < ActiveRecord::Migration
  def change
    drop_table :actions
    drop_table :occupations
    drop_table :keywords
    drop_table :reports
  end
end

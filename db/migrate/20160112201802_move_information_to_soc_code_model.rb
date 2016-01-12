class MoveInformationToSocCodeModel < ActiveRecord::Migration
  def change
    remove_column :occupations, :title
    remove_column :occupations, :description
    remove_column :occupations, :soc_code
  end
end

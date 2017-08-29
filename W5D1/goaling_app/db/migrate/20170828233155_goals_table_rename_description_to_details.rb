class GoalsTableRenameDescriptionToDetails < ActiveRecord::Migration[5.1]
  def change
    rename_column :goals, :description, :details
  end
end

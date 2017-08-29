class FixPrivateColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :goals, :pirvate, :private
  end
end

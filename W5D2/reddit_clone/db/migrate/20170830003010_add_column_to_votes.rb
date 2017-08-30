class AddColumnToVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :votes, :owner_id, :integer
  end
end

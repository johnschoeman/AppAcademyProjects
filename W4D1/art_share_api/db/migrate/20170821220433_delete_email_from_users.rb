class DeleteEmailFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, :email
    remove_column :users, :email, :string
  end
end

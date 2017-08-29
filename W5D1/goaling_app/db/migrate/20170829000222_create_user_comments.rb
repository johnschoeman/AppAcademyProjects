class CreateUserComments < ActiveRecord::Migration[5.1]
  def change
    create_table :user_comments do |t|
      t.string :body, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :user_comments, :user_id
  end
end

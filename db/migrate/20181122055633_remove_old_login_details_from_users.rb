class RemoveOldLoginDetailsFromUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :password_digest
    remove_column :users, :email
  end

  def down
    add_column :users, :password_digest, :string, null: false
    add_column :users, :email, :string, null: false
  end
end

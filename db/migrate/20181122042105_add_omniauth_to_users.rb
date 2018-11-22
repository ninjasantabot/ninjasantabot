class AddOmniauthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string, null: false
    add_column :users, :uid, :string, null: false
    add_column :users, :password, :string, null: false

    change_column_null :users, :name, true
    change_column_null :users, :email, true
  end
end

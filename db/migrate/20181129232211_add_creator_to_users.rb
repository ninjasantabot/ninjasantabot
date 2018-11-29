class AddCreatorToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :creator, :boolean, default: false, null: false
  end
end

class CreateUserGame < ActiveRecord::Migration[5.2]
  def change
    create_table :user_games do |t|
      t.references :user
      t.references :game
      t.boolean :admin, :default => false

      t.timestamps
    end
  end
end

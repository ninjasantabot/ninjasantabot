class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :game, null: false
      t.references :user, null: false
      t.references :target
      t.references :day
      t.text :key, null: false
      t.timestamp :sent_at

      t.timestamps
    end

    add_index :notifications, %i(game_id user_id day_id key), unique: true
  end
end

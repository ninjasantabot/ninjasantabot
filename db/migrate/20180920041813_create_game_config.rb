class CreateGameConfig < ActiveRecord::Migration[5.2]
  def change
    create_table :game_configs do |t|
      t.references :game
      t.integer :num_days

      t.timestamps
    end
  end
end

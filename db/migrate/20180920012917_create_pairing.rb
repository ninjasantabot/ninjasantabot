class CreatePairing < ActiveRecord::Migration[5.2]
  def change
    create_table :pairings do |t|
      t.references :target
      t.references :ninja
      t.references :game

      t.timestamps
    end
  end
end

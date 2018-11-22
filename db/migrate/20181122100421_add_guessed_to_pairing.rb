class AddGuessedToPairing < ActiveRecord::Migration[5.2]
  def change
    add_column :pairings, :guessed, :boolean, null: false, default: false
  end
end

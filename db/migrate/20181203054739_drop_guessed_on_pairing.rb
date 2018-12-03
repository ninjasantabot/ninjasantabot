class DropGuessedOnPairing < ActiveRecord::Migration[5.2]
  def change
    remove_column :pairings, :guessed, :boolean, null: false, default: false
  end
end

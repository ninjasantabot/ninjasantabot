class AddGuessedAtToPairings < ActiveRecord::Migration[5.2]
  def change
    add_column :pairings, :guessed_at, :timestamp

    Pairing.where(guessed: true).where(guessed_at: nil).update_all('guessed_at = updated_at')
  end
end

class AddGameToClues < ActiveRecord::Migration[5.2]
  def change
    add_reference :clues, :game, foreign_key: true
  end
end

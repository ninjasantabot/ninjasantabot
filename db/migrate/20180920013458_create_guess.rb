class CreateGuess < ActiveRecord::Migration[5.2]
  def change
    create_table :guesses do |t|
      t.references :user
      t.references :ninja
      t.references :day
      t.boolean :correct

      t.timestamps
    end
  end
end

class CreateClue < ActiveRecord::Migration[5.2]
  def change
    create_table :clues do |t|
      t.references :user
      t.references :target
      t.references :day
      t.string :value

      t.timestamps
    end
  end
end

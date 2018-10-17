class CreateDay < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.references :game
      t.integer :index, index: { unique: true }

      t.timestamps
    end
  end
end

class RelaxUniquenessOnGameDays < ActiveRecord::Migration[5.2]
  def change
    remove_index :days, :index
    add_index :days, [:game_id, :index], unique: true
  end
end

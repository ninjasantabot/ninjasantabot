class AddFieldsToGameConfig < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.column :signup_end_date, :date
      t.column :game_start_date, :date
      t.column :game_end_date, :date
    end

    remove_column :games, :state
    drop_table :game_configs
  end
end

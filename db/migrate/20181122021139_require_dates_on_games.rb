class RequireDatesOnGames < ActiveRecord::Migration[5.2]
  def change
    date = Date.today
    # cry a bit
    %i(signup_end_date game_start_date game_end_date).each do |col|
      change_column_default :games, col, date
      Game.update_all(col => date)
      change_column_null :games, col, false
    end
  end
end

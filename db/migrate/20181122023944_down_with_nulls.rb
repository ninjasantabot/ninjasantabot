class DownWithNulls < ActiveRecord::Migration[5.2]
  def change
    maps = {
      clues:      %i(user_id target_id day_id value),
      days:       %i(game_id index),
      games:      %i(name),
      guesses:    %i(user_id ninja_id day_id correct),
      pairings:   %i(target_id ninja_id game_id),
      user_games: %i(user_id game_id),
      users:      %i(name email password_digest),
    }

    maps.each do |table, columns|
      columns.each do |col|
        change_column_null table, col, false
      end
    end
  end
end

class Day < ApplicationRecord
  belongs_to :game

  validates_uniqueness_of :index, :scope => :game_id

  def date
    game.game_start_date + index.days
  end
end

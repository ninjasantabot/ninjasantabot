class Day < ApplicationRecord
  belongs_to :game
  has_many :clues
  has_many :guesses

  validates_uniqueness_of :index, :scope => :game_id

  def date
    game.game_start_date + index.days
  end
end

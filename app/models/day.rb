class Day < ApplicationRecord
  belongs_to :game
  has_many :clues
  has_many :guesses

  validates_uniqueness_of :index, :scope => :game_id

  scope :visible_by, -> (date) { joins(:game).where("days.index <= DATE_PART('days', ?::timestamp - games.game_start_date)", date) }

  def date
    game.game_start_date + index.days
  end
end

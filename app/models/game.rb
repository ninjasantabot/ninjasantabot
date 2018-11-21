class Game < ApplicationRecord
  has_many :user_games
  has_many :users, through: :user_games
  has_many :pairings

  has_many :days

  scope :in_signup, -> { where("signup_end_date > ?", Date.today) }
  scope :waiting_for_clues, -> { where("game_start_date > ?", Date.today) }
  scope :in_progress, -> { where("game_end_date > ?", Date.today) }
  scope :completed, -> { where("game_end_date <= ?", Date.today) }

  validates_presence_of :signup_end_date
  validates_presence_of :game_start_date
  validates_presence_of :game_end_date
  validates :dates_are_sequential

  def num_days
    (game.end_date - game.start_date).to_i
  end

  private

  def dates_are_sequential
    unless signup_end_date < game_start_date && game_start_date < game_end_date
      errors.add(:base, "Cannot have overlapping/out of order game progress dates")
    end
  end
end

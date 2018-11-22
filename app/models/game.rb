class Game < ApplicationRecord
  has_many :user_games
  has_many :users, through: :user_games
  has_many :pairings

  has_many :days
  has_many :clues, through: :days
  has_many :guesses, through: :days

  has_many :visible_days, -> { visible_by(Date.today) }, class_name: 'Day'
  has_many :visible_clues, -> { joins(day: :game) }, through: :visible_days, source: :clues
  has_many :visible_guesses, -> { joins(day: :game) }, through: :visible_days, source: :guesses

  scope :in_signup, -> { where("signup_end_date > ?", Date.today) }
  scope :waiting_for_clues, -> { where("game_start_date > ?", Date.today) }
  scope :in_progress, -> { where("game_end_date > ?", Date.today) }
  scope :completed, -> { where("game_end_date <= ?", Date.today) }

  validates_presence_of :signup_end_date
  validates_presence_of :game_start_date
  validates_presence_of :game_end_date
  validate :dates_are_sequential

  def num_days
    (game_end_date - game_start_date).to_i
  end

  private

  def dates_are_sequential
    unless signup_end_date < game_start_date
      errors.add(:base, "Signups must end before the game starts")
    end

    unless game_start_date < game_end_date
      errors.add(:base, "The game must end after starting")
    end
  end
end

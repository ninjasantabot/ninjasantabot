class Game < ApplicationRecord
  has_many :user_games, dependent: :destroy
  has_many :pairings, dependent: :destroy
  has_many :days, dependent: :destroy

  has_many :users, through: :user_games
  has_many :clues, through: :days
  has_many :guesses, through: :days

  scope :in_signup, -> { where('signup_end_date > ?', WorkaroundTime.today) }
  scope :waiting_for_clues, -> { where('game_start_date > ? and signup_end_date <= ?', WorkaroundTime.today, WorkaroundTime.today) }
  scope :in_progress, -> { where('game_start_date <= ? AND game_end_date > ?', WorkaroundTime.today, WorkaroundTime.today) }
  scope :completed, -> { where('game_end_date <= ?', WorkaroundTime.today) }

  validates_presence_of :signup_end_date
  validates_presence_of :game_start_date
  validates_presence_of :game_end_date
  validate :dates_are_sequential

  def remaining_ninjas
    users.where(id: pairings.active.pluck(:ninja_id))
  end

  def num_days
    (game_end_date - game_start_date).to_i
  end

  def current_day
    days.find_by(index: current_day_index)
  end

  def days_until_start
    (game_start_date - WorkaroundTime.today).to_i
  end

  def accepting_guesses_for?(user)
    in_progress? && pairing_targeting(user).active? && current_day.guesses.where(user: user).empty?
  end

  def pairing_targeting(target)
    pairings.preload(:target).select { |p| p.target == target }.first
  end

  def pairing_for(ninja)
    pairings.preload(:ninja).select { |p| p.ninja == ninja }.first
  end

  def in_progress?
    today = WorkaroundTime.today
    game_start_date <= today && game_end_date > today
  end

  private

  def current_day_index
    [WorkaroundTime.today - game_start_date, num_days].min.to_i
  end

  def dates_are_sequential
    unless signup_end_date < game_start_date
      errors.add(:base, 'Signups must end before the game starts')
    end

    unless game_start_date < game_end_date
      errors.add(:base, 'The game must end after starting')
    end
  end
end

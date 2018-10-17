class Game < ApplicationRecord
  enum state: {
    :opt_in => "opt_in",
    :waiting_for_clues => "waiting",
    :active => "active",
    :completed => "completed"
  }

  has_many :users, :through => :user_games
  has_many :pairings
end

class UserGame < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :user, uniqueness: { scope: :game }
end

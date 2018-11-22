class Guess < ApplicationRecord
  belongs_to :user
  belongs_to :ninja, :class_name => "User"
  belongs_to :day
end

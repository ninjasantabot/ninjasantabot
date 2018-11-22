class Guess < ApplicationRecord
  belongs_to :user
  belongs_to :ninja, :class_name => "User"
  belongs_to :day

  scope :visible_by, -> (date) { joins(day: :game).merge(Day.visible_by(date)) }
end

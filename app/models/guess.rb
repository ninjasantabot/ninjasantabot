class Guess < ApplicationRecord
  belongs_to :user
  belongs_to :ninja, class_name: 'User'
  belongs_to :day

  scope :recent_first, -> { joins(:day).merge(Day.order(index: :desc)) }
  scope :oldest_first, -> { joins(:day).merge(Day.order(index: :asc)) }

  validates_uniqueness_of :user, scope: :day
end

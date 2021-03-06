class Clue < ApplicationRecord
  belongs_to :day
  belongs_to :user
  belongs_to :target, class_name: 'User'
  belongs_to :game

  scope :recent_first, -> { joins(:day).merge(Day.order(index: :desc)) }
  scope :oldest_first, -> { joins(:day).merge(Day.order(index: :asc)) }

  def visible?
    WorkaroundTime.midday_of(day.date) <= WorkaroundTime.now
  end
end

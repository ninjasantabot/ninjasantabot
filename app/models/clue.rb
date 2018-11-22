class Clue < ApplicationRecord
  belongs_to :day
  belongs_to :user
  belongs_to :target, class_name: 'User'

  scope :visible_by, -> (date) { joins(day: :game).merge(Day.visible_by(date)) }
end

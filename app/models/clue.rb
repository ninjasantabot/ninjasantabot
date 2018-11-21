class Clue < ApplicationRecord
  belongs_to :day
  belongs_to :user
  belongs_to :target, class_name: 'User'
end

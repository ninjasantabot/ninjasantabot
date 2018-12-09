class Notification < ApplicationRecord
  belongs_to :game
  belongs_to :user
  belongs_to :target, class_name: 'User', optional: true
  belongs_to :day, optional: true

  validates :key, presence: true # not trying to replicate the uniqueness here -- null is a possible pain

  scope :unsent, -> { where(sent_at: nil) }
end

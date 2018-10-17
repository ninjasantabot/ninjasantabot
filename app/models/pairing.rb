class Pairing < ApplicationRecord
  belongs_to :game
  belongs_to :ninja, :class_name => "User"
  belongs_to :target, :class_name => "User"
end

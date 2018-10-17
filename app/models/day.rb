class Day < ApplicationRecord
  belongs_to :game

  validates_uniqueness_of :index, :scope => :game_id
end

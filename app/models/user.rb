class User < ApplicationRecord
  has_secure_password

  has_many :games, :through => :user_games
  has_many :ninjas, :through => :pairing, :foreign_key => :target_id, :class_name => "User"
  has_many :targets, :through => :pairing, :foreign_key => :ninja_id, :class_name => "User"

  validates_uniqueness_of :name
  validates_uniqueness_of :email
end

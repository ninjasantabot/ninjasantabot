class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:slack]

  has_many :user_games
  has_many :games, through: :user_games

  has_many :clues
  has_many :received_clues, foreign_key: 'target_id', inverse_of: :target, class_name: 'Clue'

  has_many :pairings
  has_many :notifications

  validates_uniqueness_of :uid

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.slack_data'] && session['devise.slack_data']['extra']['raw_info'])
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end
end

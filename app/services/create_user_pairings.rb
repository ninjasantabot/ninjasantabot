class CreateUserPairings
  attr_reader :users

  def initialize(game, users)
    @game = game
    @users = users
  end

  def call
    Pairing.transaction do
      users.shuffle.cycle.each_cons(2).take(users.size).each do |ninja, target|
        @game.pairings.create!(ninja: ninja, target: target)
      end
    end
  end
end

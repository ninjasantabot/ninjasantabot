class CreateUserPairings
  def initialize(game)
    @game = game
    @users = game.users
  end

  def call
    return if game.pairings.exists?

    Pairing.transaction do
      users.shuffle.cycle.each_cons(2).take(users.size).each do |ninja, target|
        game.pairings.create!(ninja: ninja, target: target)
        game.notifications.create!(user: ninja, target: target, key: 'ninja_mail.target_assignment')
      end
    end
  end

  private

  attr_reader :game, :users
end

class CreateUserPairings
  def initialize(game, users)
    @game = game
    @users = users
    @bot = SantaBot.new
  end

  def call
    Pairing.transaction do
      users.shuffle.cycle.each_cons(2).take(users.size).each do |ninja, target|
        game.pairings.create!(ninja: ninja, target: target)

        bot.message_user(user: ninja.email, target: target.name, message: :target_assignment)
      end
    end
  end

  private
  attr_reader :game, :users, :bot
end

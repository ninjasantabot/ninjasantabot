class CreateUserPairings
  def initialize(game, bot)
    @game = game
    @users = game.users
    @bot = bot
  end

  def call
    return if game.pairings.exists?

    Pairing.transaction do
      users.shuffle.cycle.each_cons(2).take(users.size).each do |ninja, target|
        game.pairings.create!(ninja: ninja, target: target)

        bot.message_user(user: ninja.uid, target: target.name, message: 'ninja_mail.target_assignment')
      end
    end
  end

  private

  attr_reader :game, :users, :bot
end

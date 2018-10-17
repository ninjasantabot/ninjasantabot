class CreateUserPairings
  def initialize(game, users)
    @game = game
    @users = users
  end

  def call
    id_list = @users.pluck(:id).shuffle

    Pairing.transaction do
      (0...randomised_list.count).each do |index|
        Pairing.create!(
          :game => @game,
          :ninja_id => id_list[index],
          :target_id => id_list[index-1]
        )
      end
    end

    SendTargetEmails.new(@game).call
  end
end

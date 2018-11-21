class CreateDaysForGame
  def initialize(game)
    @game = game
  end

  def call
    (0...@game.num_days).each do |index|
      Day.create!(:game => @game, :index => index)
    end
  end
end

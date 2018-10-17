class CreateDaysForGame
  def initialize(config)
    @config = config
    @game = config.game
  end

  def call
    (0...@config.num_days).each do |index|
      Day.create!(:game => @game, :index => index)
    end
  end
end

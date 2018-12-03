class MakeGuess
  def initialize(day:, game:, target:, ninja:)
    @day = day
    @game = game
    @target = target
    @ninja = ninja
  end

  def call
    guess = Guess.new(day: day, user: target, ninja: ninja, correct: correct?)

    guess.transaction do
      pairing.update!(guessed_at: Time.now) if correct?
      guess.save!
    end
  end

  private

  attr_reader :day, :game, :target, :ninja

  def correct?
    pairing.present?
  end

  def pairing
    @pairing ||= game.pairings.find_by(target: target, ninja: ninja)
  end
end

class ObservableClues
  delegate :clues, :clues, to: :game

  def initialize(game, user)
    @game = game
    @user = user
  end

  %i(current previous queued sent).each do |sym|
    define_method(sym) do
      data[sym]
    end
  end

  private

  attr_reader :game, :user

  def data
    return @data if @data

    current, *previous = clues_for(user).select(&:visible?)
    sent, queued = clues_from(user).partition(&:visible?)

    @data = {
      current:  current,
      previous: previous,
      sent:     sent,
      queued:   queued
    }
  end

  def clues_for(target)
    clues.preload(:day).where(target: target).oldest_first
  end

  def clues_from(ninja)
    clues.preload(:day).where(user: ninja).oldest_first
  end
end

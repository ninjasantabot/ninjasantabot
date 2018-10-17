class GuessesController < ApplicationController
  before_action :find_day

  def new
    @day = params.require(:day)
  end

  def create
    ninja = User.find_by(:name => params.require(:ninja_name))
    correct = Pairing.where(:game => @day.game, :ninja => ninja, :target => current_user).exists?

    Guess.create!(
      :user => current_user,
      :ninja => ninja,
      :day => @day,
      :correct => correct
    )

    redirect_to game_path(@day.game)
  end

  private

  def find_day
    @day = params.require(:day)
  end
end

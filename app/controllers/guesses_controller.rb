class GuessesController < ApplicationController
  before_action :find_day

  def new
    @guess = @day.guesses.find_by(user: current_user)
  end

  def create
    raise unless @game.guess_entry_permissible?

    ninja = User.find(ninja_id)

    MakeGuess.new(
      day: @day,
      game: @game,
      target: current_user,
      ninja: ninja
    ).call

    redirect_to @game
  rescue
    redirect_to new_game_guess_path(@game)
  end

  private

  def ninja_id
    params.require(:guess).require(:ninja_id)
  end

  def find_day
    @game = current_user.games.find(params[:game_id])
    @day = @game.current_day
  end
end

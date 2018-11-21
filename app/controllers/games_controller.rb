class GamesController < ApplicationController
  before_action :find_current_user

  def index
    @current_games = @current_user.games
    @open_games = Game.in_signup
  end

  def new
    @game = Game.new(game_params)
  end

  def create
    Game.transaction do
      game = Game.create!(game_params)
      CreateDaysForGame.new(game).call
      UserGame.create!(user: @current_user, game: game, admin: true)
    end

    redirect_to(action: :index)
  rescue ActiveRecord::RecordInvalid
    redirect_to(action: new, params: params)
  end

  def show
    @game = Game.find(params[:id])
    @current_clue, @previous_clues = @game.clues.where(target: @current_user).order(day_id: :asc)
    @guesses = @game.guesses.where(user: @current_user).order(day_id: :asc)
    @sent_clues = @game.clues.where(user: @current_user).order(day_id: :asc)
  end

  private

  def game_params
    params.require(:game).permit(
      :name,
      :signup_end_date,
      :game_start_date,
      :game_end_date
    )
  end

  def find_current_user
    @current_user = User.find(session[:user_id])
  end
end

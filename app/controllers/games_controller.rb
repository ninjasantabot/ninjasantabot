class GamesController < ApplicationController
  before_action :find_current_user

  def index
    @games = @current_user.games
  end

  def new
    @game = Game.new
  end

  def create
    Game.transaction do
      game = Game.create!(name: game_params.require(:name))
      config = GameConfig.create!(
        game: game,
        num_days: game_params.require(:num_days),
      )

      CreateDaysForGame.new(config).call
      UserGame.create!(user: @current_user, game: game, admin: true)
    end

    redirect_to(action: :index)
  end

  def show; end

  private

  def game_params
    params.require(:game)
  end

  def find_current_user
    @current_user = User.find(session[:user_id])
  end
end

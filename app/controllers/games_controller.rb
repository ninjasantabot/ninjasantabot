class GamesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :require_creator, only: %i(new create)

  def index
    @current_games = Array(current_user&.games)
    @available_games = Game.in_signup - @current_games
  end

  def new
    @game = Game.new
  end

  def create
    game = build_game(current_user, game_params)

    if game.save
      redirect_to(action: :index)
    else
      @game = game
      render :new
    end
  end

  def show
    @game = Game.find(params[:id])
    @clues = ObservableClues.new(@game, current_user)

    @guesses = @game.guesses.where(user: current_user).recent_first
  end

  def join
    @game = Game.find(params[:id])
    @game.user_games.create!(user: current_user)
    redirect_to @game
  end

  private

  def build_game(creator, params)
    Game.new(params) do |game|
      (0...game.num_days).each do |index|
        game.days.new(index: index)
      end
      game.user_games.new(user: creator, admin: true)
    end
  end

  def game_params
    filtered = params.require(:game).permit(
      :name,
      :signup_end_date,
      :game_start_date,
      :duration
    )

    end_date = filtered[:game_start_date].to_date + filtered[:duration].to_i.days
    filtered.except(:duration).merge(game_end_date: end_date)
  end
end

class GamesController < ApplicationController
  before_action :find_current_user

  def index
    @current_games = @current_user.games
    @open_games = Game.in_signup
  end

  def new
    @game = Game.new
  end

  def create
    end_date = game_params[:game_start_date].to_date + game_params[:duration].to_i.days
    game = Game.new(game_params.except(:duration).merge(:game_end_date => end_date))

    if game.save
      (0...game.num_days).each do |index|
        Day.create!(:game => game, :index => index)
      end

      UserGame.create!(user: @current_user, game: game, admin: true)
      redirect_to(action: :index)
    else
      @game = game
      render :new
    end
  end

  def show
    @game = Game.find(params[:id])
    @current_clue, *@previous_clues = @game.clues.visible_by(Date.today).where(target: @current_user).order(day_id: :asc)
    @guesses = @game.guesses.where(user: @current_user).order(day_id: :asc)
    @sent_clues = @game.clues.where(user: @current_user).order(day_id: :asc)
  end

  private

  def game_params
    params.require(:game).permit(
      :name,
      :signup_end_date,
      :game_start_date,
      :duration
    )
  end

  def find_current_user
    @current_user = User.find(session[:user_id])
  end
end

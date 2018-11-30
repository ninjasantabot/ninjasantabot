class GamesController < ApplicationController
  before_action :authenticate_user!, :except => [ :index ]
  before_action :require_creator, only: %i(new create)

  def index
    @current_games = Array(current_user&.games)
    @available_games = Game.in_signup - @current_games
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

      UserGame.create!(user: current_user, game: game, admin: true)
      redirect_to(action: :index)
    else
      @game = game
      render :new
    end
  end

  def show
    @game = Game.find(params[:id])
    @current_clue, *@previous_clues = @game.clues.where(target: current_user).order(day_id: :asc)
    @guesses = @game.guesses.where(user: current_user).recent_first
    @queued_clues = @game.clues.where(user: current_user).order(day_id: :asc).select {|clue| clue.day.date > WorkaroundTime.today}
    @sent_clues = @game.clues.where(user: current_user).order(day_id: :asc).select {|clue| clue.day.date <= WorkaroundTime.today}
  end

  def join
    @game = Game.find(params[:id])
    @game.user_games.create!(user: current_user)
    redirect_to @game
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
end

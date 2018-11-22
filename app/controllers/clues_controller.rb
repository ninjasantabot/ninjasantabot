class CluesController < ApplicationController
  before_action :find_current_user, :find_game

  def new
    @clue = Clue.new(
      :target => target,
      :day => next_clue_day
    )
  end

  def create
    clue = @current_user.clues.new(
      :target => target,
      :day => next_clue_day,
      :value => params[:clue][:value],
      :game => @game
    )

    if clue.save
      redirect_to game_path(@game)
    else
      @clue = clue
      render :new
    end
  end

  def edit
    @clue = Clue.find(params[:id])
  end

  def update
    @clue = Clue.find(params[:id])

    if @clue.update(clue_params)
      redirect_to game_path(@game)
    else
      render :edit
    end
  end

  private

  def clue_params
    params.require(:clue).permit(:value)
  end

  def target
    User.find(@game.pairings.where(ninja: @current_user).first.target_id)
  end

  def next_clue_day
    @game.days.order("days.created_at DESC").includes(:clues).where(clues: { id: nil } ).last
  end

  def find_game
    @game = Game.find(params[:game_id])
  end

  def find_current_user
    @current_user = User.find(session[:user_id])
  end
end

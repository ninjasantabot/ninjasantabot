class CluesController < ApplicationController
  before_action :authenticate_user!, :find_game

  def new
    day = next_clue_day(current_user)
    if day
      @clue = Clue.new(
        target: target,
        day: day
      )
    else
      redirect_to @game
    end
  end

  def create
    clue = current_user.clues.new(
      target: target,
      day: next_clue_day(current_user),
      value: params[:clue][:value],
      game: @game
    )

    if clue.save
      redirect_to game_path(@game)
    else
      @clue = clue
      render :new
    end
  end

  def edit
    @clue = current_user.clues.find(params[:id])
  end

  def update
    @clue = current_user.clues.find(params[:id])

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
    @game.pairing_for(current_user).target
  end

  def next_clue_day(user)
    clued_days = @game.days.joins(:clues).where(clues: { user_id: user.id })
    (@game.days - clued_days).min_by(&:index)
  end
end

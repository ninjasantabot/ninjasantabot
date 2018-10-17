class CluesController < ApplicationController
  def create
    day = params.require(:day)
    target = User.find_by(:name => params.require(:target_name))

    Clue.create!(
      :user => current_user,
      :target => target,
      :day => day,
      :value => params.require(:value)
    )

    redirect_to game_path(@day.game)
  end
end

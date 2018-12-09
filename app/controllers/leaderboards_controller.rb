class LeaderboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @game = Game.find(params[:game_id])
    @pending, @successful = @game.pairings.preload(:target, :ninja).partition(&:active?)
    @successful.sort_by!(&:guessed_at)
    @pending.sort_by! { |pair| pair.target.name }
  end
end

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def require_creator
    unless current_user.creator
      render file: "#{Rails.root}/public/403.html", status: :forbidden
    end
  end

  def find_game
    @game = Game.find(params[:game_id])
  end
end

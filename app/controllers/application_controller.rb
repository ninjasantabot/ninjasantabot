class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def require_creator
    unless current_user.creator
      render file: "#{Rails.root}/public/403.html", status: :forbidden
    end
  end
end

class SessionsController < ApplicationController
  def new
    # TODO: Devise?
  end

  def create
    # TODO: Redo for Devise
    user = User.find_by(:email => params.require(:email))

    if user.authenticate(params.require(:password))
      session[:user_id] = user.id
      redirect_to games_path
    else
      redirect_to(:action => :new)
    end
  end

  def destroy
    session.delete[:user_id]
    redirect_to(:action => :new)
  end
end

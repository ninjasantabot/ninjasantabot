class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.save!

    MailerWorker.perform_async("UserMailer", "welcome_email", { "user" => user.id })

    redirect_to(new_session_path)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

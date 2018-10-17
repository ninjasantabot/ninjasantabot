class UserMailer < ApplicationMailer
  def welcome_email
    @user = User.find(params["user"])
    @url  = 'http://tranquil-beyond-19142.herokuapp.com/'

    mail(to: @user.email, subject: 'Welcome to Ninja Santa')
  end

  def target_email
    @user = User.find(params["user"])
    @target = User.find(params["target"])
    @url = 'http://tranquil-beyond-19142.herokuapp.com/'

    mail(to: @user.email, subject: 'You have been assigned a target')
  end

  def enter_clues_email
    @user = User.find(params["user"])
    @url = 'http://tranquil-beyond-19142.herokuapp.com/'

    mail(to: @user.email, subject: 'Time is running out')
  end

  def clue_of_the_day_email
    @user = User.find(params["user"])
    @clue = Clue.find(params["clue"])
    @url = 'http://tranquil-beyond-19142.herokuapp.com/'

    mail(to: @user.email, subject: 'Time is running out')
  end

  def missing_clue_email
    @user = User.find(params["user"])

    mail(to: @user.email, subject: "Don't ruin Christmas!")
  end

  def bad_santa_email
    @user = User.find(params["user"])
    @user = User.find(params["ninja"])

    mail(to: @user.email, subject: "#{ninja.name} is getting coal for Christmas")
  end
end

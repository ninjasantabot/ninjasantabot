class RunMiddayTasks
  def call
    puts "In RunMiddayTasks"
    send_clue_reminders
    start_games
  end

  private

  def send_clue_reminders
    puts "sending clue reminders"
    game_groupings = Game.waiting_for_clues.group(&:days_until_start)

    game_groupings[3].each do |game|
      send_reminder_to_all_users(game, "ninja_mail.reminder.two_days")
    end
    game_groupings[2].each do |game|
      send_reminder_to_all_users(game, "ninja_mail.reminder.one_day")
    end
    game_groupings[1].each do |game|
      send_reminder_to_all_users(game, "ninja_mail.reminder.half_day")
    end
  end

  def send_reminder_to_all_users(game, message)
    puts "sending #{message} for game #{game.id}"
    game.users.each do |user|
      if game.clues.where(user: user).count < game.num_days
        bot.message_user(user: user.uid, message: message)
      end
    end
  end

  def start_games
    games.where(signup_end_date: Date.today).each do |game|
      CreateUserPairings.new(game).call
    end
  end
end

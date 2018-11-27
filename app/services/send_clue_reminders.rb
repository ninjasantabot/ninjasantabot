class SendClueReminders
  def call
    puts "in SendClueReminders"
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
    game.users.each do |ninja|
      if game.clues.where(user: ninja).count < game.num_days
        target = game.pairings.find_by(ninja: ninja).target
        bot.message_user(user: ninja.uid, target: target.name, message: message)
      end
    end
  end
end
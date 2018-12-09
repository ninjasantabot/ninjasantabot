class SendClueReminders
  def initialize(scope)
    @scope = scope
  end

  def call
    puts 'in SendClueReminders'
    game_groupings = @scope.group_by(&:days_until_start)
    game_groupings.default = []

    game_groupings[3].each do |game|
      send_reminder_to_all_users(game, 'ninja_mail.reminder.two_days')
    end

    game_groupings[2].each do |game|
      send_reminder_to_all_users(game, 'ninja_mail.reminder.one_day')
    end

    game_groupings[1].each do |game|
      send_reminder_to_all_users(game, 'ninja_mail.reminder.half_day')
    end
  end

  def send_reminder_to_all_users(game, message)
    puts "sending #{message} for game #{game.id}"
    game.with_lock do
      game.users.each do |ninja|
        if game.clues.where(user: ninja).count < game.num_days
          target = game.pairing_for(ninja).target
          game.notifications.create!(user: ninja, target: target, key: message)
        end
      end
    end
  end
end

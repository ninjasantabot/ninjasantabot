class SendDailyNotificationsForActiveGames
  DAY_TEXTS = {
    0 => 'day_one',
    1 => 'day_two',
    2 => 'day_three',
    3 => 'day_four',
    4 => 'day_five',
  }.freeze

  def initialize(scope)
    @scope = scope
  end

  def call
    puts 'in SendDailyNotificationsForActiveGames'
    @scope.each do |game|
      puts "sending notifications for game #{game.id}"
      day_index = game.current_day.index
      next unless notification_for_day?(day_index)

      partitions = partition_users(game)

      partitions[:ninjas].each do |user|
        puts '- sending ninjas notifications'
        send_notification(user, message_name('ninjas', day_index))
      end

      partitions[:targets].each do |user|
        puts '- sending targets notifications'
        send_notification(user, message_name('targets', day_index))
      end

      partitions[:ninja_and_targets].each do |user|
        puts '- sending ninjas and targets notifications'
        send_notification(user, message_name('ninjas_and_targets', day_index))
      end
    end
  end

  private

  def partition_users(game)
    surviving_ninjas = game.pairings.active.map(&:ninja)
    pondering_targets = game.pairings.active.map(&:target)

    {
      targets: pondering_targets - surviving_ninjas,
      ninjas: surviving_ninjas - pondering_targets,
      ninja_and_targets: surviving_ninjas & pondering_targets,
    }
  end

  def send_notification(user, message)
    game.notifications.create!(user: user, day: game.current_day, key: message)
  end

  def message_name(type, day_index)
    day_text = DAY_TEXTS[day_index]

    "ninja_mail.notifications.#{type}.#{day_text}"
  end

  def notification_for_day?(day_index)
    DAY_TEXTS.has_key?(day_index)
  end
end

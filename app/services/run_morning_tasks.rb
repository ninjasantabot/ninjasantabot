class RunMorningTasks
  def call
    puts 'In RunMorningTasks'

    send_daily_notifications_for_active_games
  end

  private

  def send_daily_notifications_for_active_games
    SendDailyNotificationsForActiveGames.new(Game.in_progress).call
  end
end

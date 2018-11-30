class RunMorningTasks
  def call
    puts "In RunMorningTasks"

    @bot = SantaBot.new

    send_daily_notifications_for_active_games
  end

  private

  def send_daily_notifications_for_active_games
    SendDailyNotificationsForActiveGames.new(@bot).call
  end
end

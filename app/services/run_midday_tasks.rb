class RunMiddayTasks
  def call
    puts "In RunMiddayTasks"
    send_clue_reminders
    start_games
  end

  private

  def send_clue_reminders
    SendClueReminders.new.call
  end

  def start_games
    games.where(signup_end_date: Date.today).each do |game|
      CreateUserPairings.new(game).call
    end
  end
end

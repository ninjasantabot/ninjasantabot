class RunMiddayTasks
  def call
    puts 'In RunMiddayTasks'

    # send_clue_reminders
    start_games
  end

  private

  def send_clue_reminders
    SendClueReminders.new(Game.waiting_for_clues).call
  end

  def start_games
    Game.where(signup_end_date: WorkaroundTime.today).each do |game|
      puts "creating pairing for game #{game.id}"
      CreateUserPairings.new(game).call
    end
  end
end

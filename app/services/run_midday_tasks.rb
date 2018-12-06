class RunMiddayTasks
  def call
    puts 'In RunMiddayTasks'

    @bot = SantaBot.new

    # send_clue_reminders
    start_games
  end

  private

  def send_clue_reminders
    SendClueReminders.new(@bot, Game.waiting_for_clues).call
  end

  def start_games
    Game.where(signup_end_date: WorkaroundTime.today).each do |game|
      puts "creating pairing for game #{game.id}"
      CreateUserPairings.new(game, @bot).call
    end
  end
end

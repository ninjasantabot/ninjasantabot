class SendTargetEmails
  def initialize(game)
    @game = game
  end

  def call
    Game.pairings.each do |pairing|
      MailerWorker.perform_async(
        "UserMailer",
        "target_email",
        { "user" => pairing.ninja_id, "target" => pairing.target_id }
      )
    end
  end
end

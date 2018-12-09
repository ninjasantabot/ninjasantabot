class SantaBot
  def initialize
    @client = Slack::Web::Client.new
  end

  def send_notification(notification)
    notification.with_lock do
      raise if notification.sent_at

      notification.update!(sent_at: Time.now)
      message_user(
        user: notification.user.uid,
        message: notification.key,
        target: notification.target.name
      )
    end
  end

  def message_user(user:, message:, target: nil)
    client.chat_postMessage(
      channel: user,
      text: format_message(message, target),
      as_user: true
    )
  end

  private

  attr_reader :client

  def format_message(message, target)
    [
      I18n.t('ninja_mail.header'),
      body(message, target)
    ].join("\n")
  end

  def body(message, target)
    if target.present?
      I18n.t(message, target: target)
    else
      I18n.t(message)
    end
  end
end

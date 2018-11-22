class SantaBot
  def initialize
    @client = Slack::Web::Client.new
  end

  def message_user(user:, message:, target: nil)
    client.chat_postMessage(
      channel: channels[user],
      text: format_message(message, target),
      as_user: true
    )
  end

  private

  attr_reader :client

  def format_message(message, target)
    if target.present?
      I18n.t(message, target: target)
    else
      I18n.t(message)
    end.join("\n")
  end

  def channels
    @channels ||= users.each_with_object({}) { |user, obj| obj[user.profile.email] = user.id }
  end

  def users
    @users ||= client.users_list.members
  end
end

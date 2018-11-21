class SantaBot
  def initialize
    @client = Slack::Web::Client.new
  end

  def message_user(email, message)
    channel = user_channels[email]

    client.chat_postMessage(channel: channel, text: message, as_user: true)
  end

  private

  attr_reader :client

  def user_channels
    @user_channels ||= users.each_with_object({}) { |user, obj| obj[user.profile.email] = user.id }
  end

  def users
    @users ||= client.users_list.members
  end
end

class MailerWorker
  include Sidekiq::Worker

  def perform(mail_class, mail_name, params)
    mailer = mail_class.constantize
    mailer.with(params).send(mail_name.to_sym).deliver_now
  end
end

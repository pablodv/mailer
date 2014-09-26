class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def message(user, emails, message, subject)
    @user    = user
    @message = message

    mail to: email, subject: subject
  end
end

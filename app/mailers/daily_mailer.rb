class DailyMailer < ApplicationMailer
  layout 'mailer'

  def daily_digest(user)
    @questions = Question.where('created_at > ?', DateTime.now - 1.day)
    mail(to: user.email, subject: 'Daily Digest For You')
  end
end

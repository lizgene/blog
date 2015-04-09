class VisitorMailer < ActionMailer::Base
  default from: "liz.hubertz@gmail.com"

  def share(to_email, from_email, message)
    @message = message
    mail(to: to_email, from: from_email, subject: "Check out this post on Liz and Nathan's travel blog!", tag: "blog: share")
  end
end

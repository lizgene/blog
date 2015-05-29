class SubscriberMailer < ActionMailer::Base
  default from: "liz.hubertz@gmail.com"

  def welcome(subscriber)
    @subscriber = subscriber
    mail(to: @subscriber.email, subject: "Welcome to Liz and Nathan's Travel Blog!", tag: "blog: welcome")
  end
end

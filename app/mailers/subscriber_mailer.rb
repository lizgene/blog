class SubscriberMailer < ActionMailer::Base
  default from: "liz.hubertz@gmail.com"

  def welcome(subscriber)
    @subscriber = subscriber
    mail(to: @subscriber.email, subject: "Welcome to Liz and Nathan's Travel Blog!", tagline: "Get ready for awesome.", tag: "blog: welcome")
  end
end

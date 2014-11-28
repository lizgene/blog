class Subscriber < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email

  after_create :send_welcome_email

  def send_welcome_email
    SubscriberMailer.welcome(self).deliver
  end
end

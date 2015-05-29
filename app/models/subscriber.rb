class Subscriber < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email

  after_create :send_welcome_email, :update_mailchimp

  def send_welcome_email
    SubscriberMailer.welcome(self).deliver
  end

  def update_mailchimp
    begin
      gb = MailchimpDelivery.new("newsletter")
      gb.subscribe(self)
      logger.info("Mailchimp Success: Subscribed #{email}")
    rescue Gibbon::MailChimpError => e
      logger.info("Mailchimp Failure for #{email}: #{e.message}")
    end
  end

end

class SubscribersController < ApplicationController

  # GET /subscribers/new
  def new
    @subscriber = Subscriber.new
  end

  # POST /subscribers
  # POST /subscribers.json
  def create
    @subscriber = Subscriber.new(subscriber_params)

    respond_to do |format|
      if @subscriber.save
        format.html { redirect_to root_path, notice: 'Successfully subscribed!' }
      else
        format.html { redirect_to root_path, alert: "There was a problem saving: #{@subscriber.errors.full_messages.join(', ')}" }
      end
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:first_name, :email)
  end

end
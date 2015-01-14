class CheckpointsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :new, :destroy]
  before_action :set_checkpoint, only: [:show, :edit, :update, :destroy]

  def index
    @trips = Trip.all.order('created_at DESC').page(params[:page]).per_page(10)
  end

  def show
  end

  def new
    @checkpoint = Checkpoint.new(ip_address: request.remote_ip)
  end

  def create
    #street address can override ip address if you want to manually input a checkpoint
    params[:checkpoint].delete("ip_address") if params[:checkpoint][:street_address].present?

    @checkpoint = Checkpoint.new(checkpoint_params)

    respond_to do |format|
      if @checkpoint.save
        format.html { redirect_to trips_path(@checkpoint.trip), notice: 'Checkpoint was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @checkpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkpoint
      @checkpoint = Checkpoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checkpoint_params
      params.require(:checkpoint).permit(:latitude, :longitude, :ip_address, :street_address, :user_id, :trip_id)
    end
end

class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @countries = Country.all
    @user = current_user
  end


  def create
    @country = Country.find(params[:country_id])
    @booking = Booking.new(booking_params)
    @booking.country = @country
    @booking.user = current_user
    if @booking.save
      redirect_to bookings_path
    else
      render "countries/show", status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :country_id, :user_id)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

end

class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy]
  before_action :set_country, only: [:create] 

  def index
    @bookings = current_user.bookings if user_signed_in?
  end

  def show
    @booking = Booking.find(params[:id])
    @country = @booking.country

    @markers =
      {
        lat: @country.latitude,
        lng: @country.longitude,
        info_window_html: render_to_string(partial: "countries/info_window", locals: { country: @country }, formats: [:html])
      }
  end

  def new
    @booking = Booking.new
    @countries = Country.all
  end

  def create
    @booking = @country.bookings.new(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to bookings_path
    else
      flash.now[:alert] = @booking.errors.full_messages.to_sentence
      render "countries/show", status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_country
    @country = Country.find(params[:country_id])
  end
end

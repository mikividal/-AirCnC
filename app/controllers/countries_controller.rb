class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :destroy, :update, :edit]


  def index
    @countries = Country.all
  end

  def new
    @country = Country.new
    @user = current_user
  end

  def create
  @country = Country.new(country_params.except(:photos))
  @country.user = current_user
  if @country.save
    if params[:country][:photos].present?
      @country.photos.attach(params[:country][:photos])
    end
    redirect_to countries_path
  else
    render :new, status: :unprocessable_entity
  end
  end

  def show
    @booking = Booking.new
    @user = current_user
  end

  def destroy
    @country.destroy
    redirect_to countries_path, status: :see_other
  end

  def update
    if @country.update(country_params)
      redirect_to country_path(@country)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end

  private

  def country_params
    params.require(:country).permit(:name, :capital_city, :price, :tag_line, :description, :main_language, photos: [])
  end

  def set_country
    @country = Country.find(params[:id])
  end
end

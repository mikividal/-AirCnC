class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :destroy, :update, :edit, :create]

  def index
    @countries = Country.all
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(params[:id])
    if @country.save
      redirect_to country_path(@country)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
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
    params.require(:country).permit(:name, :price, :tag_line, :description, :user_id, :main_language)
  end

  def set_country
    @country = Country.find(params[:id])
  end
end

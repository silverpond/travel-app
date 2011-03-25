class TravelController < ApplicationController

  def index
  end

  def travel
    @from_airport = Airport.where(:code => params[:travel][:from]).first
    @to_airport = Airport.where(:code => params[:travel][:to]).first

    weather_service = Service::WorldWeatherOnline.new @to_airport.latitude,@to_airport.longitude, 5
    @weather_days = weather_service.weather_days

  end

end

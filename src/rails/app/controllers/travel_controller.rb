class TravelController < ApplicationController

  def index
  end

  def travel
    @from_airport = Airport.where(:code => params[:travel][:from]).first
    @to_airport = Airport.where(:code => params[:travel][:to]).first

    weather_service = Service::WorldWeatherOnline.new @to_airport.latitude,@to_airport.longitude, 5
    @weather_days = weather_service.weather_days

    @from_currency = @from_airport.currency
    @exchange = @from_currency.convert_to @to_airport.currency

    geo_name_service = Service::GeoNamesTimezone.new @to_airport.latitude,@to_airport.longitude
    @local_time_at_destination = geo_name_service.current_date_time

  end

end

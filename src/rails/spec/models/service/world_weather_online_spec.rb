require 'spec_helper'
require 'json'
require 'open-uri'

describe Service::WorldWeatherOnline do
  before(:each) do
    lat = 20.00
    lng = 20.00
    @service = Service::WorldWeatherOnline.new(lat, lng, 5)
  end

  it "should connect to World Weather Online service" do
    url = "http://www.worldweatheronline.com/feed/weather.ashx?q=20.00,20.00&format=json&num_of_days=5&key=c1b49d1767235416112203"
    world_weather = open(url)
    test_weather_data = JSON.parse(world_weather.read)

    @service.current_condition_icon_url.should_not be_nil
    @service.current_condition_temp_celcius.should_not be_nil
    @service.current_condition_desription.should_not be_nil
    @service.current_condition_observed_at.should_not be_nil

  end

end

require 'spec_helper'
require 'json'
require 'open-uri'

describe Service::GeoNamesTimezone do
  before(:each) do
    lat = 45.01
    lng = 10.2
    @service = Service::GeoNamesTimezone.new(lat, lng) 
  end
  
  it "should connect to geo names timezone service" do
    url = "http://api.geonames.org/timezoneJSON?formatted=true&lat=45.01&lng=10.2&username=demo&style=full"
    geo_names = open(url)
    test_timezone_data = JSON.parse(geo_names.read)

    @service.gmt_offset.should_not be_nil
    @service.gmt_offset.should == test_timezone_data["gmtOffset"]
    @service.current_date_time.should_not be_nil
    @service.timezone_id.should_not be_nil
    @service.timezone_id.should == test_timezone_data["timezoneId"]
    Time.zone = test_timezone_data["timezoneId"]
    @service.current_date_time.should == Time.zone.parse(test_timezone_data["time"])
  end
end

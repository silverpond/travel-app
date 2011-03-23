require 'spec_helper'
require 'json'
require 'open-uri'

describe Service::BrigherPlanetFlight do
  context "Carbon Footprint" do
    before(:each) do
      @service = Service::BrigherPlanetFlight.new('MEL', 'LAX')
    end

    it "should connect to carbon.brighterplanet.com and return flight data" do
      url = "http://carbon.brighterplanet.com/flights.json?key=8ac3f57be86f0fb305cde54c30d97ce3&origin_airport[iata_code]=MEL&destination_airport[iata_code]=LAX"
      brighter_planet = open(url)
      test_carbon_data = JSON.parse(brighter_planet.read)

      @service.emission.should_not be_nil
      @service.emission.should eq(test_carbon_data["emission"])
      @service.emission_units.should_not be_nil
      @service.emission_units.should eq(test_carbon_data["emission_units"])
    end
    
    it "should have to string" do
      @service.to_s.should == "7042.156 kilograms"
    end

  end

end

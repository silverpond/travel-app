require 'spec_helper'
require 'json'
require 'open-uri'

describe Service do
  context "Carbon Footprint" do
    it "should connect to carbon.brighterplanet.com and return flight data" do

      url = "http://carbon.brighterplanet.com/flights.json?key=8ac3f57be86f0fb305cde54c30d97ce3&origin_airport[iata_code]=MEL&destination_airport[iata_code]=LAX"
      brighter_planet = open(url)
      test_carbon_data = JSON.parse(brighter_planet.read)

      source_carbon_data = Service.brighter_planet_flight_carbon_footprint_for('MEL', 'LAX')

      source_carbon_data["emission"].should_not be_nil
      source_carbon_data["emission"].should eq(test_carbon_data["emission"])
      source_carbon_data["emission_units"].should_not be_nil
      source_carbon_data["emission_units"].should eq(test_carbon_data["emission_units"])

    end
  end

end

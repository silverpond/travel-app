class Service::BrigherPlanetFlight
  BRIGHTER_PLANET_KEY = "8ac3f57be86f0fb305cde54c30d97ce3"
 
  @source_json = nil

  attr_reader :emission, :emission_units

  def initialize( source, dest )
    url = "http://carbon.brighterplanet.com/flights.json?key=#{BRIGHTER_PLANET_KEY}&origin_airport[iata_code]=#{source}&destination_airport[iata_code]=#{dest}"
    
    brighter_planet = open(url)

    @source_json = JSON.parse(brighter_planet.read)
    
    @emission = @source_json["emission"]
    @emission_units = @source_json["emission_units"]
  end

end

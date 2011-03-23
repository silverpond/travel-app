class Service
  BRIGHTER_PLANET_KEY = "8ac3f57be86f0fb305cde54c30d97ce3"
  
  def Service.brighter_planet_flight_carbon_footprint_for( source, dest )
    url = "http://carbon.brighterplanet.com/flights.json?key=#{BRIGHTER_PLANET_KEY}&origin_airport[iata_code]=#{source}&destination_airport[iata_code]=#{dest}"
    
    brighter_planet = open(url)

    JSON.parse(brighter_planet.read)
  end
end

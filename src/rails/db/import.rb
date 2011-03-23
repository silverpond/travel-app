require_relative '../config/environment'

airports_text = IO.read('db/imports/GlobalAirportDatabase.txt')

airports_text.lines.each do |line|
  airport_code4, airport_code3, airport_name, city, country,lat_d,lat_m,lat_s,lat_p,long_d,long_m,long_s,long_p,alt = line.split ':'

  next if airport_code3 == 'N/A' # Ignore small airports

  airport = Airport.new

  airport.code = airport_code3
  airport.name = airport_name
  airport.city = city
  airport.country = country

  airport.save!

end

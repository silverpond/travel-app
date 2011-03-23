require 'csv'
require_relative '../config/environment'

def import_airports
  airports_text = IO.read('db/imports/GlobalAirportDatabase.txt')

  airports_text.lines.each do |line|
    airport_code4, airport_code3, airport_name, city, country,lat_d,lat_m,lat_s,lat_p,long_d,long_m,long_s,long_p,alt = line.split ':'

    next if airport_code3 == 'N/A' # Ignore small airports

    airport = Airport.new

    airport.code = airport_code3
    airport.name = airport_name
    airport.city = city
    airport.country = country

    airport.latitude = lat_d.to_f  + ((lat_m.to_f + (lat_s.to_f / 60.0)) / 60.0)
    airport.longitude = long_d.to_f + ((long_m.to_f + (long_s.to_f / 60.0)) / 60.0)

    airport.latitude *= lat_p == 'S' ? -1 : 1
    airport.longitude *= long_p == 'W' ? -1 : 1

    puts airport.inspect

    airport.save!

  end
end


def import_currencies
  airports_text = IO.read('db/imports/dl_iso_table_a1.csv')

  CSV.foreach 'db/imports/dl_iso_table_a1.csv' do |row|
    country,currency_name,currency_code,numeric_code,minor_unit = row

    currency = Currency.new
    currency.name = currency_name
    currency.code = currency_code
    currency.country = country

    currency.save!

  end
end



Airport.transaction do
  import_airports
end

Currency.transaction do
  import_currencies
end

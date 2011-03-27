require 'csv'
require_relative '../config/environment'

# imports data downloaded from http://www.partow.net/miscellaneous/airportdatabase/
def import_global_airports_database
  airports_text = IO.read('db/imports/GlobalAirportDatabase.txt')

  airports_text.lines.each do |line|
    airport_code4, airport_code3, airport_name, city, country,lat_d,lat_m,lat_s,lat_p,long_d,long_m,long_s,long_p,alt = line.split ':'

    next if airport_code3 == 'N/A' # Ignore small airports

    airport = Airport.new

    airport.code = airport_code3
    airport.name = airport_name
    airport.city = city
    airport.country = country

    #convert from radians to degrees
    airport.latitude = lat_d.to_f  + ((lat_m.to_f + (lat_s.to_f / 60.0)) / 60.0)
    airport.longitude = long_d.to_f + ((long_m.to_f + (long_s.to_f / 60.0)) / 60.0)

    airport.latitude *= lat_p == 'S' ? -1 : 1
    airport.longitude *= long_p == 'W' ? -1 : 1

    puts airport.inspect

    airport.save!

  end
end

# imports data downloaded from http://www.openflights.org/data.html
def import_open_flights_airports
  CSV.foreach('db/imports/open_flights_airports_database.csv') do |row|

    id, name, city, country, code3, code4, lat, lng, alt, timezone, dst = row

    airport = Airport.new(
      :code => code3.upcase,
      :name => name.upcase,
      :city => city.upcase,
      :country => country.upcase,
      :latitude => lat,
      :longitude => lng,
      :altitude => alt,
      :timezone => timezone,
      :daylight_savings_zone => dst
    )

    puts airport.inspect
    airport.save!
  end
end

def import_currencies
  CSV.foreach 'db/imports/dl_iso_table_a1.csv' do |row|
    country,currency_name,currency_code,numeric_code,minor_unit = row

    currency = Currency.new
    currency.name = currency_name
    currency.code = currency_code
    currency.country = country
    
    puts currency.inspect
    currency.save!

  end
end

def update_currency( set_country, where_country )
  sql = ActiveRecord::Base.connection
  sql.execute "UPDATE currencies 
               SET country = '#{set_country}' 
               WHERE country = '#{where_country}'"
end

Airport.transaction do
  puts "importing airports..."
  import_open_flights_airports

end

Currency.transaction do
  puts "importing currencies..."
  import_currencies
  #cleanup data to be the same as airports
  
  puts "updating currency countries"
  update_currency('BOLIVIA', 'BOLIVIA, PLURINATIONAL STATE OF')
  update_currency('BRUNEI', 'BRUNEI DARUSSALAM')
  update_currency('BOSNIA AND HERZEGOVINA', 'BOSNIA & HERZEGOVINA')
  update_currency('CONGO (BRAZZAVILLE)', 'CONGO')
  update_currency('CONGO (KINSHASA)', 'CONGO, THE DEMOCRATIC REPUBLIC OF')
  update_currency('EAST TIMOR', 'TIMOR-LESTE')
  update_currency('FALKLAND ISLANDS', 'FALKLAND ISLANDS (MALVINAS)')
  update_currency('IRAN', 'IRAN, ISLAMIC REPUBLIC OF')
  update_currency('NORTH KOREA', 'KOREA, DEMOCRATIC PEOPLE\\\'S REPUBLIC OF')
  update_currency('SOUTH KOREA', 'KOREA, REPUBLIC OF')
  update_currency('LAOS', 'LAO PEOPLE\\\'S DEMOCRATIC REPUBLIC')
  update_currency('LIBYA', 'LIBYAN ARAB JAMAHIRIYA')
  update_currency('MACAU', 'MACAO')
  update_currency('MACEDONIA', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF')
  update_currency('MICRONESIA', 'MICRONESIA, FEDERATED STATES OF')
  update_currency('MOLDOVA', 'MOLDOVA, REPUBLIC OF')
  update_currency('PALESTINE', 'PALESTINIAN TERRITORY, OCCUPIED')
  update_currency('RUSSIA', 'RUSSIAN FEDERATION')
  update_currency('SAINT HELENA', 'SAINT HELENA, ASCENSION AND TRISTAN DA CUNHA')
  update_currency('SOUTH GEORGIA AND THE ISLANDS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS')
  update_currency('SVALBARD', 'SVALBARD AND JAN MAYEN')
  update_currency('SYRIA', 'SYRIAN ARAB REPUBLIC')
  update_currency('TAIWAN', 'TAIWAN, PROVINCE OF CHINA')
  update_currency('TANZANIA', 'TANZANIA, UNITED REPUBLIC OF')
  update_currency('VENEZUELA', 'VENEZUELA, BOLIVARIAN REPUBLIC OF')
  update_currency('VIETNAM', 'VIET NAM')

  update_currency('BRITISH VIRGIN ISLANDS', 'VIRGIN ISLANDS (BRITISH)')
  update_currency('VIRGIN ISLANDS', 'VIRGIN ISLANDS (US)')

end

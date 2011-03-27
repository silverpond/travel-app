require 'open-uri'

class Service::GeoNamesTimezone
  
  attr_accessor :gmt_offset,
                :current_date_time,
                :timezone_id

  def initialize lat, lng
    url = "http://api.geonames.org/timezoneJSON?formatted=true&lat=#{lat}&lng=#{lng}&username=silverpond&style=full"
    geo_names_uri = open(url)
    @source_data = JSON.parse(geo_names_uri.read)
    
    @gmt_offset = @source_data["gmtOffset"]
    @timezone_id = @source_data["timezoneId"]
    
    Time.zone = @timezone_id
    @current_date_time = Time.zone.parse(@source_data["time"])
  end
end

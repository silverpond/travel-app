class Service::WorldWeatherOnline
  KEY = "c1b49d1767235416112203" 

  attr_accessor :current_condition_icon_url,
                :current_condition_temp_celcius,
                :current_condition_desription,
                :current_condition_observed_at,
                :weather_days

  def initialize lat, lng, num_days
    @source_data = nil
    @weather_days = []
    
    url = "http://www.worldweatheronline.com/feed/weather.ashx?q=#{lat},#{lng}&format=json&num_of_days=#{num_days}&key=#{KEY}"
    
    world_weather_uri = open(url)
    
    @source_data = JSON.parse(world_weather_uri.read)
   
    current_condition = @source_data["data"]["current_condition"]
    
    @current_condition_icon_url = current_condition[0]["weatherIconUrl"][0]["value"] 
    @current_condition_desription = current_condition[0]["weatherDesc"][0]["value"] 
    @current_condition_temp_celcius = current_condition[0]["temp_C"]
    @current_condition_observed_at = current_condition[0]["observation_time"]
 
    if source_weather = @source_data["data"]["weather"]
      source_weather.each do |source_weather_day|
        @weather_days << {
          :date => source_weather_day["date"],
          :temp_max_celcius => source_weather_day["tempMaxC"],
          :temp_min_celcius => source_weather_day["tempMinC"],
          :description => source_weather_day["weatherDesc"][0]["value"],
          :icon_url => source_weather_day["weatherIconUrl"][0]["value"]
        }
      end
    end
  end

  

end


module ApplicationHelper
  def latlng_interp(from, to, n)
    tl = to.longitude.to_f
    fl = from.longitude.to_f    
    if (tl - fl).abs > 180
      lng_d = (180 - fl.abs) + (180 - tl.abs)
      
      if tl >= 0
        lng_d = -lng_d
      end
    else
      lng_d = tl - fl
    end
    
    lat_d = to.latitude.to_f - from.latitude.to_f
    
    lat_n = lat_d / n.to_f 
    lng_n = lng_d / n.to_f
    
    a = []
    lat,lng = from.latitude.to_f,from.longitude.to_f
    (n+1).times do
      a << ("%.1f,%.1f" % [lat, lng])
      lat += lat_n
      lng = clip(lng + lng_n)
    end
    
    s = a.join("|")
    logger.warn s
    return s
  end
  
  def clip(x)
    if x > 180
      return -180 + (x - 180)
    elsif x < -180
      return 180 + (x + 180)
    else
      x
    end
  end
  
end

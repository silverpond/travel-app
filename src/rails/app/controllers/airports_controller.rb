class AirportsController < ApplicationController

  def autocomplete_by_name
    @airports = Airport.search(params[:term]).limit(10)
    render :json => @airports.map{|x| { :label => "#{x.name}, #{x.country}(#{x.code})", :value => x.code } }
  end

end

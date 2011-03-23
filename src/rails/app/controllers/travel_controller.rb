class TravelController < ApplicationController

  def index
  end

  def travel
    @from_airport = Airport.where(:code => params[:travel][:from]).first
    @to_airport = Airport.where(:code => params[:travel][:to]).first
  end

end

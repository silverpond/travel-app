require 'spec_helper'

describe TravelController do
  context "when on the index page" do
    before(:each) do
      get :index
    end

    it { response.should be_success }
  end

  
  context "should post to travel action" do
    before(:each) do
      @from_airport = Airport.make!(:MEL)
      @to_airport = Airport.make!(:LAX)
      @from_currency = Currency.make!(:AUD)
      @to_currency = Currency.make!(:USD)
      
      post :travel, { 
          :travel => { :from => "MEL", :to => "LAX" } 
        }
    end

    it { assigns[:from_airport].code.should == @from_airport.code }
    it { assigns[:to_airport].code.should == @to_airport.code }
    it { assigns[:from_currency].code.should == @from_currency.code }
    it { assigns[:exchange].should_not be_nil }
    it { assigns[:brighter_planet_service].should_not be_nil }
    it { assigns[:weather_days].should_not be_nil }
  end
end

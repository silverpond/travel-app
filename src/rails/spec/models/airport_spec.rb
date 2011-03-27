require 'spec_helper'

describe Airport do
  before(:each) do
    @mel_airport = Airport.create!(:code => "MEL", :city => "Melbourne", :country => "Australia")
    @lax_airport = Airport.create!(:code => "LAX", :city => "Los Angeles", :country => "USA")
    
  end

  it "should validate presence of country for currency lookup" do
    airport = Airport.new(:code => "ITM")
    airport.save
    airport.should_not be_valid
    airport.errors.has_key?(:country).should be_true
  end

  it "should look up currency" do
    @currency = Currency.create!(:code => "USD",
                                  :country => "USA")

    @lax_airport.currency.should_not be_nil
    @lax_airport.currency.code.should == "USD"
  end
end

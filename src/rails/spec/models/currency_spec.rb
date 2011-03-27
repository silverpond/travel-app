require 'spec_helper'

describe Currency do
  before(:each) do
    @from_currency = Currency.new(:code => "AUD")
  end

  it "should convert to a specified currency" do
    to_currency = Currency.new(:code => "USD")
    amt = @from_currency.convert_to to_currency
    amt.class.should == Money
  end

  it "should raise an error if the currency is invalid" do
    expect {@from_currency.convert_to(nil)}.to raise_error("invalid currency")
  end
end

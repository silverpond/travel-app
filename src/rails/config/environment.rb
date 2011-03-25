# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
TravelApp::Application.initialize!

# set default bank to instance of GoogleCurrency
Money.default_bank = Money::Bank::GoogleCurrency.new


require 'integration_test_helper'

class TravelFlowTest < ActionDispatch::IntegrationTest
  fixtures :all

  test 'getting to homepage' do
    visit '/'
    assert page.has_content? 'Travel App'
  end

  test 'submit from and to airports and see next page with more info' do
    visit '/'
    fill_in 'travel_from', :with => 'MEL'
    fill_in 'travel_to', :with => 'KIX'
    click_button 'Fly'
    assert page.has_content? 'Kansai International Airport'
    assert page.has_content? 'MELBOURNE International Airport'
  end

end

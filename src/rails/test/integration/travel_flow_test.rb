
require 'integration_test_helper'

class TravelFlowTest < ActionDispatch::IntegrationTest
  fixtures :all

  test 'getting to homepage' do
    visit '/'
    assert page.has_content? 'Travel App'
  end

  test 'submit from and to airports and see next page with more info' do
    visit '/'
    fill_in 'From', :with => 'MEL'
    fill_in 'To', :with => 'KIX'
    click_button_or_line 'Fly'
    assert page.has_content? 'Kansai International Airport'
    assert page.has_content? 'Tullamarine International Airport'
  end

end

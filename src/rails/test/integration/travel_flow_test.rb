
require 'integration_test_helper'

class TravelFlowTest < ActionDispatch::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test 'getting to homepage' do
    visit '/'
    assert page.has_content? 'Travel All'
  end
  
end

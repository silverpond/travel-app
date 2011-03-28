require 'spec_helper'

describe TravelController do
  context "when on the index page" do
    before(:each) do
      get :index
    end

    it { response.should be_success }
  end

  
  context "should post to travel action" do
    it "params MEL and LAX" do
      
    end
  end
end

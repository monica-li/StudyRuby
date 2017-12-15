require 'spec_helper'

describe "increase the temperature" do
  before :all do
	SpecHelper::open_session_with_login
  end
  
  it "increase temperature" do
   ProjectDefaultPage.increase_temperature
   expect(page.has_content?("Welcome")).to be true
  end

  it "cancel increase temperature" do
    ProjectDefaultPage.cancel_increase_temperature
    expect(page.has_content?("Welcome")).to be true
  end
  
  after :all do
    Util.sign_out
  end

end

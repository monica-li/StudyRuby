require 'spec_helper'

describe "add multiple temperatures" do
  before :all do
	SpecHelper::open_session_with_login
  end
  
  it "add more than one temperatures" do
    f=File.dirname(__FILE__) + '/weather-m.yml'
	MonitorWeatherEditor.new_mul_weather(f)
	
  end

  after :all do
    Util.sign_out
  end

end

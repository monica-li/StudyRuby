require 'spec_helper'

describe "add multiple temperatures" do
  before :all do
#	SpecHelper::open_session_with_login
  end

  it "add 24 hours weather information of Beijing 16 districts from moji" do
	f=File.dirname(__FILE__) + '/moji24h-beijing.json'
	auth={:host=>"47.92.123.34", :port=>"8080", :reststr=>"private"}
	MonitorWeatherEditor.add_24hour_weather_from_moji_by_rest(auth,f)
#	MonitorWeatherEditor.add_24hour_weather_from_moji(f)	
  end

  after :all do
#    Util.sign_out
  end

end

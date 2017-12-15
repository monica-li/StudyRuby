require 'spec_helper'

describe "increase the temperature" do
  before :all do
	SpecHelper::open_session_with_login
  end
  
  it "increase temperature" do
    weather=SpecHelper::load_config(File.expand_path(File.dirname(__FILE__) + '/weather.yml'))
    MonitorWeatherEditor.new_weather(weather)
    expect(page.has_content?("Welcome")).to be true
  end

  after :all do
    Util.sign_out
  end

end

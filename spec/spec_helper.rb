require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'rspec'
require 'yaml'
require 'ostruct'

require './lib/hot_cloud/util.rb'
require './lib/hot_cloud/projectdefaultpage.rb'
require './lib/hot_cloud/monitorWeatherEditor.rb'

include HotCloud::UI
include Capybara::DSL

module SpecHelper
  
  @@SERVER_CONFIG_PATH = './spec/environment.yaml'
		
  ## 
  # 
  # Loads our environment.yaml file, opens our session using selenium,
  # and then logs in as the user from environment.
  #
  def open_session_with_login
    $system_config ||= load_config(@@SERVER_CONFIG_PATH)
    url = "#{$system_config.protocol}://#{$system_config.host}:#{$system_config.port}"
    Util.open_session(url)
    Util.login($system_config.user, $system_config.password)
  end

  def login_with_current_session
    $system_config ||= load_config(@@SERVER_CONFIG_PATH)
    Util.login($system_config.user, $system_config.password)
  end

  ##
  #
  # This loads our config from ./spec/environment.yaml which contains
  # our protocol:server:port:user:pass, and passes it back in an OpenStruct
  # 
  # @param [String] file_path string where the environment.yaml file lives
  # @return [OpenStruct] an OpenStruct that contains the key, value pairs from our YAML file.
  def load_config(file_path)
    config = OpenStruct.new
	file_path.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?
    YAML.load_file(file_path).each do |k,v|
      config.send("#{k}=", v)
    end

    config.browser ||= "firefox"
    config.username ||= config.user

    return config
  end

  def get_host
    $system_config ||= load_config(@@SERVER_CONFIG_PATH)
    $system_config.host
  end

  def get_port
    $system_config ||= load_config(@@SERVER_CONFIG_PATH)
    $system_config.port
  end

  def get_auth
    $system_config ||= load_config(@@SERVER_CONFIG_PATH)
    { :host => $system_config.host, :port => $system_config.port, :user => $system_config.host, :password => $system_config.password }
  end
  
end

include SpecHelper

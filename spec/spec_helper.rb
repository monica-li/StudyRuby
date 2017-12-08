require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'rspec'
require 'yaml'
require 'ostruct'

Dir[File.expand_path("../lib/**/*.rb",__FILE__)].each do |rb|
  require rb
end

include Capybara::DSL

module SpecHelper
  
  @@SERVER_CONFIG_PATH = './spec/environment.yaml'
  ##
  #
  # This method actually opens the session using selenium. This can be modified to use different drivers, changing the flavor of t
  # the test in one place. In the case of selenium, this opens the browsing session.
  #
  # @param [String] url	session url example: "http://dsqapc04:8080/livecluster/admin/control/dashboard/dashboard_index.jsp"
  def open_session(url, browser="firefox")
    Capybara.run_server = false
    browser = browser.downcase
	$system_config ||= load_config(@@SERVER_CONFIG_PATH)
    @download_directory ||=  $system_config.download_dir
    @download_directory.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?
    Capybara.register_driver :selenium_browser do |app|
      case browser
      when "firefox"
        profile = Selenium::WebDriver::Firefox::Profile.new
        profile['browser.download.folderList'] = 2
        profile["browser.download.dir"] = @download_directory
        profile['browser.helperApps.neverAsk.saveToDisk'] = "application/java-archive;application/zip;application/pdf"
        profile['browser.download.manager.showWhenStartin'] = false
        #profile['pdfjs.disabled'] = true
        Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
      when "chrome"
        Capybara::Selenium::Driver.new(app, :browser => :chrome)
      when "ie"
        Capybara::Selenium::Driver.new(app, :browser => :ie)
      when "safari"
        Capybara::Selenium::Driver.new(app, :browser => :safari)
      end
    end

    Capybara.default_driver = :selenium_browser
    Capybara.app_host = url
    Capybara.default_wait_time=15
    visit("")
  end
  
  ##
   #
   # Login to the initial screen for TIBCO Silver Fabric.
   #
   # 	login('admin', 'admin')
   #
   # @param [String] username 	username to login with
   # @param [String] password 	password to login with
   def login(username, password, account="cloud")
     fill_in('username', :with=> username)
     fill_in('password', :with=> password)
     click_button('')
   end
		
  ## 
  # 
  # Loads our environment.yaml file, opens our session using selenium,
  # and then logs in as the user from environment.
  #
  def open_session_with_login
    $system_config ||= load_config(@@SERVER_CONFIG_PATH)
    url="http://#{$system_config.host}:#{$system_config.port}"
    open_session(url)
    login($system_config.user, $system_config.password)
  end

  ## 
  # 
  # Loads our environment.yaml file, opens our session using selenium.
  # Does NOT login, enabling pre-login tests
  #
  def open_session_without_login
    $system_config ||= load_config(@@SERVER_CONFIG_PATH)
    url="http://#{$system_config.host}:#{$system_config.port}"
    open_session(url)
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

  def get_current_date(i=0)
    date = Time.now+(86400*i)
    mon = date.month
    if mon < 10
      mon = "0#{mon}"
    end
    day = date.day
    if day < 10
      day = "0#{day}"
    end
    "#{mon}/#{day}/#{date.year}"
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

  def screenshot
    require 'fileutils'
    screenshot_dir = "screenshot"
    @time_now = Time.now
    time_string = "#{@time_now.strftime('%Y.%m.%d-%H.%M.%S.')}#{'%03d' % (@time_now.usec/1000).to_i}"

    RSpec.configure do |config|
      config.after do |example|
        # our code sets the driver when we need to use capybara we're basically checking to
        # see if we're using capybara to determine whether we need to take a screenshot
        # we don't need to take a screenshot when testing things like rest because there's no browswer
        if Capybara.current_driver == :selenium_browser && example.exception
          FileUtils.mkpath(screenshot_dir) unless Dir.exist?(screenshot_dir)
          file_name = "#{example.description}.png".gsub(" ", "_").gsub(/[^a-zA-Z0-9_.]/, "")
          full_path = "#{screenshot_dir}/#{time_string}-#{file_name}"
          page.driver.browser.save_screenshot(full_path)
        end
      end
    end
  end
end

include SpecHelper

SpecHelper.screenshot

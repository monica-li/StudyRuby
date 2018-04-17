require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'rspec'

##
# This is a demo file, which needs to be updated to be better organized.

describe "verify the build" do
 before :all do
 	username = "username"
 	password = "password"
 	hosturl = "http://yourhost"

    Capybara.run_server = false
    browser = browser.downcase
    Capybara.register_driver :selenium_browser do |app|
      case browser
      when "firefox"
        Capybara::Selenium::Driver.new(app, :browser => :firefox)
      when "chrome"
        Capybara::Selenium::Driver.new(app, :browser => :chrome)
      when "ie"
        Capybara::Selenium::Driver.new(app, :browser => :ie)
      when "safari"
        Capybara::Selenium::Driver.new(app, :browser => :safari)
      end
    end

    Capybara.default_driver = :selenium_browser
    Capybara.app_host = hosturl
    Capybara.default_max_wait_time=15
    visit("")
 end

 it "Login the system" do
   fill_in('username', :with=> username)
   fill_in('password', :with=> password)
   click_button('')
   expect(page.has_content?("Welcome")).to be true
 end

  it "increase temperature" do
    current_page = page.driver.browser.window_handle
    find(:id, "increasetempraturebutton").click
    i=0
    while page.driver.browser.window_handles.size < 2
      sleep 0.3
      i = i+0.3
      if i > 3
        break
      end
    end
    popup = switch_to_window(windows.last)
    within_window(popup) do
      find(:id, "doincrease").click
    end
    i=0
    while page.driver.browser.window_handles.size > 1
      sleep 0.3
      i = i+0.3
      if i > 3
        break
      end
    end
    page.driver.browser.switch_to.window(current_page)
    expect(page.has_content?("Welcome")).to be true
  end

 it "Logout the system" do
   find('a', :text=>'Quit').click
   expect(page.has_content?("Welcome")).to be false
 end
 
end
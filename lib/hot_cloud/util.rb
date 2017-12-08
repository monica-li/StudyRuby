require 'capybara'
require 'capybara/dsl'
require 'selenium/client'
require 'selenium-webdriver'

##
# Util is the module which provides the common methods for the UI. They
# are called by other files. People also can use it to do some actions that exist
# in most of the pages.

module HotCloud
  module UI
    module Util
      class << self
        include Capybara::DSL
		
		@@download_dir = './spec/downloadfiles'

        ##
        #
        # This method actually opens the session using selenium. This can be modified to use different drivers, changing the flavor of t
        # the test in one place. In the case of selenium, this opens the browsing session.
        #
        # @param [String] url	session url example: "http://dsqapc04:8080/livecluster/admin/control/dashboard/dashboard_index.jsp"
        def open_session(url, browser="firefox")
          Capybara.run_server = false
          browser = browser.downcase
          @download_directory ||=  @@download_dir
          @download_directory.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?
          Capybara.register_driver :selenium_browser do |app|
            case browser
            when "firefox"
              profile = Selenium::WebDriver::Firefox::Profile.new
              profile['browser.download.folderList'] = 2
              profile["browser.download.dir"] = @download_directory
              profile['browser.helperApps.neverAsk.saveToDisk'] = "application/java-archive;application/zip;application/pdf"
              profile['browser.download.manager.showWhenStartin'] = false
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
		# Login to the initial screen
		# 	login('admin', 'admin')
		# @param [String] username 	username to login with
		# @param [String] password 	password to login with
		def login(username, password)
  		  fill_in('username', :with=> username)
		  fill_in('password', :with=> password)
		  click_button('')
		end

        ##
        #
        # A helper method to check the alert present or not
        #
        def alert_present?
          begin
            page.driver.browser.switch_to.alert
            return true
          rescue Selenium::WebDriver::Error::NoAlertPresentError
            return false
          end
        end
		
        ##
        #
        # A helper method to return the alert text, if alert exist, accept it and return it's text
        #
        def get_alert
          alert = page.driver.browser.switch_to.alert
          info = alert.text
          alert.accept
          return info
        end
		
        ##
        #
        # sign out the TIBCO Silver Fabric.
        def sign_out
          find(:data-ng-click, 'doLogout()').click
        end

        ##
        # A helper method to simplify the operation of popup window , for example
        #     Util.popup_window{
        #       page.execute_script "window.close()"
        #     }
        #
        def popup_window
          Util.wait_open_popup_window
          popup = page.driver.browser.window_handles.last
          within_window(popup) do
            yield
            Util.wait_close_popup_window
          end
        end

        ##
        # A helper method to wait the popup window to be closed
        #
        def wait_close_popup_window
          i=0
          while page.driver.browser.window_handles.size > 1
            sleep 0.3
            i = i+0.3
            if i > 3
              break
            end
          end
        end

        ##
        # A helper method to wait the popup window to be opened
        #
        def wait_open_popup_window
          i=0
          while page.driver.browser.window_handles.size < 2
            sleep 0.3
            i = i+0.3
            if i > 3
              break
            end
          end
        end

      end
    end
  end
end

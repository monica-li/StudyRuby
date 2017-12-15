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
        #
        def open_session(url, browser="firefox")
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
          Capybara.app_host = url
          Capybara.default_max_wait_time=15
          visit("")
        end

		##
		# Login to the initial screen
		# 	login('admin', 'admin')
		# @param [String] username 	username to login with
		# @param [String] password 	password to login with
        #
		def login(username, password)
  		  fill_in('username', :with=> username)
		  fill_in('password', :with=> password)
		  click_button('')
		end
		
        ##
        #
        # sign out the system.
        #
        def sign_out
           find('a', :text=>'Quit').click
        end

        ##
        # A helper method to simplify the operation of popup window , for example
        #     Util.popup_window{
        #       page.execute_script "window.close()"
        #     }
        #
        def popup_window
          Util.wait_open_popup_window
#          popup = page.driver.browser.window_handles.last
		  popup = switch_to_window(windows.last)
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

require File.expand_path(File.dirname(__FILE__) + '/util')

module HotCloud
  module UI
    module ProjectDefaultPage
      class << self
        include Capybara::DSL
        
		##
        # Whether to increase the temperature
        #   ProjectDefaultPage.increase_temperature?()
        #
        def increase_temperature
		  current_page = page.driver.browser.window_handle
		  find(:id, "increasetempraturebutton").click
		  Util.popup_window do
			find(:id, "doincrease").click
		  end
          Util.wait_close_popup_window
          page.driver.browser.switch_to.window(current_page)
        end
		
        def cancel_increase_temperature
		  current_page = page.driver.browser.window_handle
		  Util.popup_window do
			find(:id, "cancel").click
		  end
          Util.wait_close_popup_window
          page.driver.browser.switch_to.window(current_page)
        end
		
      end
    end
  end
end

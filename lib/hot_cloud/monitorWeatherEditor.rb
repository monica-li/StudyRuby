require File.expand_path(File.dirname(__FILE__) + '/util')

module HotCloud
  module UI
    module MonitorWeatherEditor
      class << self
        include Capybara::DSL
        
		##
        # Add new weather
        #   MonitorWeatherEditor.new_weather(weather)
        #
        def new_weather(weather)
		  find('li', :text=>'监测数据').click
		  find('li', :text=>'分时天气数据').click
		  current_page = page.driver.browser.window_handle
		  click_button('newbt')
		  Util.popup_window do
		    fill_in('date', :with=>weather.day)
			select(weather.hour, :from => "hour")
			select(weather.province, :from => "province")
			select(weather.city, :from => "city")
			select(weather.district, :from => "district")
			fill_in(weather.street, :with=>weather.street)
			select(weather.lightcondition, :from => "lightCondition")
			select(weather.raincondition, :from => "rainCondition")
			select(weather.windspeed, :from => "wind_speed")
			fill_in('temprature', :with=>weather.temperature)
			fill_in('humity', :with=>weather.humity)
  		    click_button('dobt')
		  end
          Util.wait_close_popup_window
          page.driver.browser.switch_to.window(current_page)
        end
		
        def cancel_new_weather
		  find('li', :text=>'监测数据').click
		  find('li', :text=>'分时天气数据').click
		  current_page = page.driver.browser.window_handle
		  click_button('newbt')
		  Util.popup_window do
			click_button('cancelbt')
		  end
          Util.wait_close_popup_window
          page.driver.browser.switch_to.window(current_page)
        end

		##
        # Add more than one new weathers
        #   MonitorWeatherEditor.new_weather(weatherfilepath)
        #
        def new_mul_weather(weatherfilepath)
		  find('li', :text=>'监测数据').click
		  find('li', :text=>'分时天气数据').click
		  current_page = page.driver.browser.window_handle
		  weatherfilepath.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?
		  YAML.load_file(weatherfilepath).each do |k,v|
			puts k
		    w = OpenStruct.new
		    v.each do |vk,vv|
			  w.send("#{vk}=", vv)
			end
			click_button('newbt')
			Util.popup_window do
		      fill_in('date', :with=>w.day)
			  select(w.hour, :from => "hour")
			  select(w.province, :from => "province")
			  select(w.city, :from => "city")
			  select(w.district, :from => "district")
			  fill_in(w.street, :with=>w.street)
			  select(w.lightcondition, :from => "lightCondition")
			  select(w.raincondition, :from => "rainCondition")
			  select(w.windspeed, :from => "wind_speed")
			  fill_in('temprature', :with=>w.temperature)
			  fill_in('humity', :with=>w.humity)
  		      click_button('dobt')
		    end
            
		  end
		  
		  Util.wait_close_popup_window
          page.driver.browser.switch_to.window(current_page)
		  
        end
		
      end
    end
  end
end

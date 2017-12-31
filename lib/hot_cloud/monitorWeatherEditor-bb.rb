require File.expand_path(File.dirname(__FILE__) + '/util')
require 'json'

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
        # Get weather information from moji
        #   MonitorWeatherEditor.add_24hour_weather_from_moji(weatherfilepath)
        #
        def add_24hour_weather_from_moji(weatherfilepath)
		  weatherfilepath.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?
		  jsl=[]
		  File.open(weatherfilepath, 'r:utf-8') do |file|
		   file.each do |line|
		    jsl.push(line)
		   end
		  end

		  find('li', :text=>'监测数据').click
		  find('li', :text=>'分时天气数据').click
		  current_page = page.driver.browser.window_handle
		  
		  district=""
		  date=""
		  hour=""
		  light=""
		  rain=""
		  windSpeed="<3"
		  temp="0"
		  humidity="0"
		  jsl.each do |j|
		    diqu=JSON.parse(j)
		    diqu.each do |k,v|
#		     puts k
		     if k == "data" 
		       v.each do |dk,dv|
		         dv.each do |dkk,dkv|
		           if dkk == "name"
		            district = dkv
		            puts district
		           end
		         end
		         if dk == "hourly"
		           dv.each do |hdk,hdv|
		             hdk.each do |tqk,tqv|
#					   puts tqk,tqv
					   case tqk
					   when "date"
						 date=tqv
						 puts date
					   when "hour"
						 hour=tqv
						 puts hour
					   when "condition"
						 case tqv
						 when "晴"
						   light="晴"
						 when "雾"
						   light="多云"
						   rain=tqv
						 when "多云"
						   light="多云"
						 when "少云"
						   light="多云"
					     else
						   light="阴天"
						   rain=tqv
						 end
					   when "windSpeed"
						 case tqv
						 when 12 .. 19
						   windSpeed="3"
						 when 20 .. 28
						   windSpeed="4"
						 when 29 .. 38
						   windSpeed="5"
						 when 39 .. 49
						   windSpeed="6"
						 when 50 .. 61
						   windSpeed="7"
						 else
						   windSpeed="8"
						 end
					   when "temp"
						 temp=tqv
					   when "humidity"
						 humidity=tqv
					   end
					   click_button('newbt')
					   Util.popup_window do
						 fill_in('date', :with=>date)
						 select(hour, :from => "hour")
					     select("北京", :from => "province")
						 select("北京市", :from => "city")
						 select(district, :from => "district")
						 select(light, :from => "lightCondition")
						 select(rain, :from => "rainCondition")
						 select(windSpeed, :from => "wind_speed")
						 fill_in('temprature', :with=>temp)
						 fill_in('humity', :with=>humidity)
						 click_button('dobt')						 
					   end
					 end
		           end
		         end
		       end
		     end
		    end
		  end
        end
		
		##
        # Add more than one new weathers
        #   MonitorWeatherEditor.new_mul_weather(weatherfilepath)
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

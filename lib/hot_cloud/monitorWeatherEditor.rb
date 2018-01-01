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
        # Get weather information from moji and return it as a json list
        #   MonitorWeatherEditor.get_24h_json_list(mojifile)
        #
        def get_24h_json_list(mojifile)
          mojifile.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?
          jsl=[]
          File.open(mojifile, 'r:utf-8') do |file|
            file.each do |line|
              jsl.push(line)
            end
          end
          jsl
        end

        ##
        # Get useful weather information from moji hour hash data and return it as a new hash
        #   MonitorWeatherEditor.get_useful_weather(mojihour)
        #
        def get_useful_weather(mojihour)
          useful={"date"=>"2017-12-31", "hour"=>"11","lightCondition"=>"晴","rainCondition"=>"无", "humidity"=>"15","temprature"=>"3", "wind_speed"=>"9"}
          mojihour.each do |k,v|
            case k
            when "date"
              useful["date"]=v
            when "hour"
              case v
              when "0"
			    useful["hour"]="00"
              when "1"
			    useful["hour"]="01"
              when "2"
			    useful["hour"]="02"
              when "3"
			    useful["hour"]="03"
              when "4"
			    useful["hour"]="04"
              when "5"
			    useful["hour"]="05"
              when "6"
			    useful["hour"]="06"
              when "7"
			    useful["hour"]="07"
              when "8"
			    useful["hour"]="08"
              when "9"
			    useful["hour"]="09"
              else
			    useful["hour"]=v
              end
			when "humidity"
              useful["humidity"]=v
            when "temprature"
              useful["temprature"]=v
            when "condition"
              case v
              when "晴"
                useful["lightCondition"]="晴"
                useful["rainCondition"]="无"
              when "多云"
                useful["lightCondition"]="多云"
                useful["rainCondition"]="无"
              when "少云"
                useful["lightCondition"]="多云"
                useful["rainCondition"]="无"
              when "雾"
                useful["lightCondition"]="多云"
                useful["rainCondition"]=v
              else
                useful["lightCondition"]="阴天"
                useful["rainCondition"]=v
              end
            when "windSpeed"
              v=v.to_i
              case v
              when 0 .. 11
                useful["wind_speed"]="<3"
              when 12 ..19
                useful["wind_speed"]="3"
              when 20 .. 28
                useful["wind_speed"]="4"
              when 29 .. 38
                useful["wind_speed"]="5"
              when 39 .. 49
                useful["wind_speed"]="6"
              else
                useful["wind_speed"]="8"
              end
            end
          end
          useful
        end

		##
        # Get weather information from moji
        #   MonitorWeatherEditor.add_24hour_weather_from_moji(weatherfilepath)
        #
        def add_24hour_weather_from_moji(weatherfilepath)

		  jsl=get_24h_json_list(weatherfilepath)

		  find('li', :text=>'监测数据').click
		  find('li', :text=>'分时天气数据').click
		  current_page = page.driver.browser.window_handle
		  
		  chengqu=""
		  jsl.each do |j|
		    diqu=JSON.parse(j)
		    diqu.each do |k,v|
#		     puts k
		     if k == "data" 
               v.each do |dk,dv|
                 dv.each do |dkk,dkv|
                   if dkk == "name"
                     chengqu = dkv
					 case chengqu
					 when "北京市朝阳区"
					   chengqu = "朝阳区"
					 when "北京市通州区"
					   chengqu = "通州区"
					 when "密云区"
					   chengqu = "密云县"
					 when "延庆区"
					   chengqu = "延庆县"
					 end
                     puts chengqu
                   end
                 end
                 if dk == "hourly"
                   dv.each do |hourk|
                     tianqi=get_useful_weather(hourk)
					 
                     click_button('newbt')
                     Util.popup_window do
                       fill_in('date', :with=>tianqi["date"])
                       select(tianqi["hour"], :from => "hour")
                       puts tianqi["date"],tianqi["hour"]
                       select("北京", :from => "province")
                       select("北京市", :from => "city")
                       select(chengqu, :from => "district")
                       select(tianqi["lightCondition"], :from => "lightCondition")
                       select(tianqi["rainCondition"], :from => "rainCondition")
                       select(tianqi["wind_speed"], :from => "wind_speed")
                       fill_in('temprature', :with=>tianqi["temprature"])
                       fill_in('humity', :with=>tianqi["humity"])
                       click_button('dobt')						 
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

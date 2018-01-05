require File.expand_path(File.dirname(__FILE__) + '/util')
require 'json'
require 'rest_client'

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
        #   MonitorWeatherEditor.get_24h_moji_json_list(mojifile)
        #
        def get_24h_moji_json_list(mojifile)
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
        # add weather by rest api
        #		
        def add_weather_by_rest(auth,weather_json)
          rest_agent=RestClient::Resource.new("http://#{auth[:host]}:#{auth[:port]}/#{auth[:reststr]}/ry/weather")
          rest_agent.post(weather_json, :content_type=>"application/json;charset=utf-8")
        end

        ##
        # Get hotcloud's weather information from moji hour hash data which is used by rest api
        # 		and return it as a new hash
        #   MonitorWeatherEditor.get_hotcloud_info_from_moji(mojihour)
        #
        def get_hotcloud_info_from_moji_rest(mojihour,district)
          hotcloud={"project.id"=>"5","time"=>1514736000000,"wind_speed"=>"LESSTHREE","temprature"=>30,"humidity"=>45,"province"=>"北京","city"=>"北京市","district"=>"东城区","dataType"=>"RAW","weather_type"=>"SUNNY","lightCondition"=>"SUNNY","rainCondition"=>"NONE","street"=>"","light"=>0,"top_temprature"=>0,"low_temprature"=>0}
          date=""
          hour=""
          mojihour.each do |k,v|
            case k
            when "date"
              date=v
            when "hour"
              case v
              when "0"
			    hour="00"
              when "1"
			    hour="01"
              when "2"
			    hour="02"
              when "3"
			    hour="03"
              when "4"
			    hour="04"
              when "5"
			    hour="05"
              when "6"
			    hour="06"
              when "7"
			    hour="07"
              when "8"
			    hour="08"
              when "9"
			    hour="09"
              else
			    hour=v
              end
			when "humidity"
              hotcloud["humidity"]=v
            when "temp"
              hotcloud["temprature"]=v
            when "condition"
              case v
              when "晴","大部晴朗"
                hotcloud["weather_type"]="SUNNY"
                hotcloud["lightCondition"]="SUNNY"
                hotcloud["rainCondition"]="NONE"
              when "少云","多云"
                hotcloud["weather_type"]="CLOUDY"
                hotcloud["lightCondition"]="CLOUDY"
                hotcloud["rainCondition"]="NONE"
              when "阴","霾","尘卷风","扬沙","浮尘","沙尘暴","强沙尘暴"
                hotcloud["weather_type"]="OVERCASE"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="NONE"
              when "雾","冻雾"
                hotcloud["weather_type"]="FOG"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="NONE"
              when "雷暴","雷电"
                hotcloud["weather_type"]="OVERCASE"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="NONE"
              when "小阵雨","阵雨","强阵雨","局部阵雨","雷阵雨"
                hotcloud["weather_type"]="SHOWER"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="SHOWER"
              when "雷阵雨伴有冰雹"
                hotcloud["weather_type"]="SHOWERWITHICE"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="SHOWERWITHICE"
              when "小雨"
                hotcloud["weather_type"]="LIGHTRAINY"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="LIGHTRAINY"
              when "雨","中雨"
                hotcloud["weather_type"]="RAINY"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="RAINY"
              when "小到中雨"
                hotcloud["weather_type"]="LIGHTRAINTORAIN"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="LIGHTRAINTORAIN"
              when "中到大雨"
                hotcloud["weather_type"]="RAINTOHEAVYRAIN"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="RAINTOHEAVYRAIN"
              when "大雨"
                hotcloud["weather_type"]="HEAVYRAINY"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="HEAVYRAINY"
              when "大到暴雨"
                hotcloud["weather_type"]="HEAVYRAINTOSTORM"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="HEAVYRAINTOSTORM"
              when "暴雨"
                hotcloud["weather_type"]="STORM"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="STORM"
              when "大暴雨","特大暴雨"
                hotcloud["weather_type"]="HEAVYSTORM"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="HEAVYSTORM"
              when "冰粒","冰针","冰雹","冻雨"
                hotcloud["weather_type"]="ICERAIN"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="ICERAIN"
              when "雨夹雪"
                hotcloud["weather_type"]="SHOWERWITHSNOW"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="SHOWERWITHSNOW"
              when "雪","中雪"
                hotcloud["weather_type"]="SNOW"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="SNOW"
              when "小阵雪","阵雪"
                hotcloud["weather_type"]="SNOWSHOWER"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="SNOWSHOWER"
              when "小雪"
                hotcloud["weather_type"]="LIGHTSNOW"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="LIGHTSNOW"
              when "小到中雪"
                hotcloud["weather_type"]="LIGHTSNOWTOSNOW"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="LIGHTSNOWTOSNOW"
              when "大雪"
                hotcloud["weather_type"]="HEAVYSNOW"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="HEAVYSNOW"
              when "暴雪"
                hotcloud["weather_type"]="BLIZZARD"
                hotcloud["lightCondition"]="OVERCASE"
                hotcloud["rainCondition"]="BLIZZARD"
              else
                hotcloud["weather_type"]="SUNNY"
                hotcloud["lightCondition"]="SUNNY"
                hotcloud["rainCondition"]="NONE"
              end
            when "windSpeed"
              v=v.to_i
              case v
              when 0 .. 11
                hotcloud["wind_speed"]="LESSTHREE"
              when 12 ..19
                hotcloud["wind_speed"]="THREE"
              when 20 .. 28
                hotcloud["wind_speed"]="FOUR"
              when 29 .. 38
                hotcloud["wind_speed"]="FIVE"
              when 39 .. 49
                hotcloud["wind_speed"]="SIX"
              when 50 .. 61
                hotcloud["wind_speed"]="SEVEN"
              when 62 .. 74
                hotcloud["wind_speed"]="EIGHT"
              else
                hotcloud["wind_speed"]="MORETHANEIGHT"
              end
            end
          end
          hotcloud["time"]=Util.get_microsecond(date,hour)
		  hotcloud["district"]=district
          hotcloud
        end

		##
        # Add weather information to hotcloud with data from moji by rest api
        #   MonitorWeatherEditor.add_24hour_weather_from_moji(weatherfilepath)
        #
        def add_24hour_weather_from_moji_by_rest(auth,weatherfilepath)
		  jsl=get_24h_moji_json_list(weatherfilepath)
		  chengqu=""
		  jsl.each do |j|
		    diqu=JSON.parse(j)
		    diqu.each do |k,v|
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
				     puts hourk["date"]+": "+hourk["hour"]
                     tianqi=get_hotcloud_info_from_moji_rest(hourk,chengqu)
					 wjson=JSON.generate(tianqi)
					 puts wjson
                     add_weather_by_rest(auth,wjson)
                   end
                 end
               end
		     end
		    end
		  end
        end

        ##
        # Get useful weather information from moji hour hash data and return it as a new hash
        #   MonitorWeatherEditor.get_hotcloud_info_from_moji(mojihour)
        #
        def get_hotcloud_info_from_moji(mojihour)
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
            when "temp"
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
              when "阴"
                useful["lightCondition"]="阴天"
                useful["rainCondition"]="无"
              else
                useful["lightCondition"]="阴天"
                useful["rainCondition"]="阴天"
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
        # Add weather information to hotcloud with data from moji
        #   MonitorWeatherEditor.add_24hour_weather_from_moji(weatherfilepath)
        #
        def add_24hour_weather_from_moji(weatherfilepath)

		  jsl=get_24h_moji_json_list(weatherfilepath)

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
                     tianqi=get_hotcloud_info_from_moji(hourk)
					 
                     click_button('newbt')
                     Util.popup_window do
                       fill_in('date', :with=>tianqi["date"])
                       select(tianqi["hour"], :from => "hour")
                       puts tianqi["date"]+": "+tianqi["hour"]
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

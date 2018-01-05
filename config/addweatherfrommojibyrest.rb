require 'json'
require 'rest_client'

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
        def get_hotcloud_info_from_moji_rest(mojihour)
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
                     tianqi=get_hotcloud_info_from_moji_rest(hourk)
                     wjson=JSON.generate(tianqi)
                     add_weather_by_rest(auth,wjson)
                   end
                 end

             end
           end
         end

       end

f=File.dirname(__FILE__) + '/moji24h-beijing.json'
auth={:host=>"47.92.123.34", :port=>"8080", :reststr=>"api/private"}
add_24hour_weather_from_moji_by_rest(auth,f)

require 'json'
require 'rest_client'

def get_24h_json_list(mojifile)
#  weatherfilepath.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?
  jsl=[]
  File.open(mojifile, 'r:utf-8') do |file|
    file.each do |line|
      jsl.push(line)
    end
  end
  jsl
end

def get_useful_weather(mojihour)
  useful={"date"=>"2017-12-31", "hour"=>"11","light"=>"晴","rain"=>"无", "humidity"=>"15","temp"=>"3", "windSpeed"=>"9"}
  mojihour.each do |k,v|
    case k
    when "date"
      useful["date"]=v
    when "hour"
      useful["hour"]=v
    when "humidity"
      useful["humidity"]=v
    when "temp"
      useful["temp"]=v
    when "condition"
     case v
      when "晴"
        useful["light"]="晴"
        useful["rain"]="无"
      when "多云"
        useful["light"]="多云"
        useful["rain"]="无"
      when "少云"
        useful["light"]="多云"
        useful["rain"]="无"
      when "雾"
        useful["light"]="多云"
        useful["rain"]=v
      else
        useful["light"]="阴天"
        useful["rain"]=v
      end
    when "windSpeed"
      v=v.to_i
      case v
      when 0 .. 11
        useful["windSpeed"]="<3"
      when 12 ..19
        useful["windSpeed"]="3"
      when 20 .. 28
        useful["windSpeed"]="4"
      when 29 .. 38
        useful["windSpeed"]="5"
      when 39 .. 49
        useful["windSpeed"]="6"
      else
        useful["windSpeed"]="8"
      end
    end
  end
  useful
end

def get_json_from_hash(json_hash)
  JSON.generate(json_hash)
end

def get_rest_agent()
  url="http://47.92.123.34:8080/api/private"
  username="qiushijiayuan"
  pwd="qsjy1234"
  RestClient::Resource.new(url, :user=>username, :password=>pwd)
end

rest_agent=get_rest_agent()
rest_agent["ry/weather"].get

moji="tt.json"

json_list=get_24h_json_list(moji)

#puts json_list.length

json_list.each do |json|
  city=JSON.parse(json)
  city.each do |k,v|
    if k == "data"
      v.each do |datak,datav|
#        puts datak
        datav.each do |cityk,cityv|
          if cityk == "name"
            puts cityv
          end
        end
        if datak == "hourly"
#          puts datav
          datav.each do |hour|
            ww=get_useful_weather(hour)
            ww_json=get_json_from_hash(ww)
          end
        end

      end
    end
  end
end

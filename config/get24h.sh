#!/bin/sh

appCode=af6c4d0e9d3544268e5dd1292bd71b07
token=008d2ad9197090c5dddc76f583616606
url="http://lliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"

outputfile="output.txt"
datafile="./data24h.json"

curl -i -X POST "http://lliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=284609&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=284610&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=3&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=4&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=5&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=6&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=7&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=8&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=9&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=10&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=11&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=12&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=13&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=14&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=15&token=008d2ad9197090c5dddc76f583616606" >>data24h.json
curl -i -X POST "http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"  -H "Authorization:APPCODE $appCode" --data "cityId=22&token=008d2ad9197090c5dddc76f583616606" $outputfile

sed -e "1,14d" -e "16,42d" -e '44,56d' -e '58,70d' -e '72,84d' -e '86,98d' -e '100,11    2d' -e '114,126d' -e '128,140d' -e '142,154d' -e '156,168d' -e '170,182d' -e '184,19    d' -e '198,210d' -e '212,224d' -e 's#\}HTTP/1.1 200 OK#\}#' $outputfile > $datafile

count=0
count=`wc -l $datafile`
if [ count!=16 ]; then
  echo "Something is wrong......"
fi

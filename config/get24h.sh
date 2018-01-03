#!/bin/sh

appCode=af6c4d0e9d3544268e5dd1292bd71b07
token=008d2ad9197090c5dddc76f583616606
url="http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"

outputfile="output.txt"
datafile="./moji24h-beijing.json"

curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=284609&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=284610&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=3&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=4&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=5&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=6&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=7&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=8&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=9&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=10&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=11&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=12&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=13&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=14&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=15&token=$token" >>$outputfile
curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "cityId=22&token=$token" >>$outputfile

cp $outputfile $datafile
sed -i -e '/^HTTP/d' -e '/^Server/d' -e '/^Date/d' -e '/^Content/d' -e '/^Connection/d' -e '/^Vary/d' -e '/^Access/d' -e '/^X-Ca/d' -e '/^$/d' -e 's#\}HTTP/1.1 200 OK#\}#' $datafile

datafile2rspec="../spec/monitor/moji24h-beijing.json"
d=`date +%Y%m%d`
datafilejdate="../data/moji24h-beijing-"$d".json"
count=0
count=`cat $datafile|wc -l`
if [ count==15 ]; then
  echo "OKOKOK"
  cp $datafile $datafile2rspec
  cp $datafile $datafilejdate
  rm $outputfile
else
  echo $count
  echo "Something is wrong......"
fi

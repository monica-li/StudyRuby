#!/bin/sh

appCode=af6c4d0e9d3544268e5dd1292bd71b07
token=1b89050d9f64191d494c806f78e8ea36
url="http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours"
lat=40.226092
lon=116.211613

cityurl="http://aliv18.data.moji.com/whapi/json/alicityweather/forecast24hours"
citytoken=008d2ad9197090c5dddc76f583616606

outputfile="output.txt"
datafile="./moji24h-qiushi.json"

curl -i -X POST $url  -H "Authorization:APPCODE $appCode" --data "lat=$lat&lon=$lon&token=$token" >>$outputfile
curl -i -X POST $cityurl  -H "Authorization:APPCODE $appCode" --data "cityId=5&token=$citytoken" >>$outputfile

cp $outputfile $datafile
sed -i -e '/^HTTP/d' -e '/^Server/d' -e '/^Date/d' -e '/^Content/d' -e '/^Connection/d' -e '/^Vary/d' -e '/^Access/d' -e '/^X-Ca/d' -e '/^$/d' -e 's#\}HTTP/1.1 200 OK#\}#' $datafile

datafile2rspec="../spec/monitor/moji24h-qiushi.json"
d=`date +%Y%m%d`
datafilejdate="../data/moji24h-qiushi-"$d".json"
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

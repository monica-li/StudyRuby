#!/bin/sh

appCode=
token=1b89050d9f64191d494c806f78e8ea36

dclat=39.91488908
dclon=116.40387397

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$dclat&lon=$dclon&token=$token' >>data24h.json

xclat=
xclon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$xclat&lon=$xclon&token=$token' >>data24h.json

cylat=
cylon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$cylat&lon=$cylon&token=$token' >>data24h.json

ftlat=
ftlon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$ftlat&lon=$ftlon&token=$token' >>data24h.json

sjslat=
sjslon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$sjslat&lon=$sjslon&token=$token' >>data24h.json

hdlat=
hdlon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$hdlat&hdlon=$lon&token=$token' >>data24h.json

mtglat=
mtglon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$mtglat&lon=$mtglon&token=$token' >>data24h.json

fslat=
fslon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$fslat&fslon=$lon&token=$token' >>data24h.json

tzlat=
tzlon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$tzlat&lon=$tzlon&token=$token' >>data24h.json

sylat=
sylon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$sylat&lon=$sylon&token=$token' >>data24h.json

cplat=
cplon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$cplat$lon=$cplon&token=$token' >>data24h.json

dxlat=
dxlon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$dxlat&lon=$dxlon&token=$token' >>data24h.json

hrlat=
hrlon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$hrlat&lon=$hrlon&token=$token' >>data24h.json

pglat=
pglon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$pglat&lon=$pglon&token=$token' >>data24h.json

mylat=
mylon=

curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$mylat&lon=$mylon&token=$token' >>data24h.json

yqlat=
yqlon=
curl -i -X POST 'http://aliv8.data.moji.com/whapi/json/aliweather/forecast24hours'  -H 'Authorization:APPCODE $appCode' --data 'lat=$yqlat&lon=$yqlon&token=$token' >>data24h.json



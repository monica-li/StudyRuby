#!/bin/sh
# This shell is used to backup mysql database
# at 2018-01-03 by monica-li

serverip=47.92.123.34
serveruser=root

dbpath=/var/lib/mysql

d=`date +%Y%m%d`
localpath="/g/HotCloud/dbbak/"$d

if [ ! -d $localpath ]; then
 echo "create local backup path: "$localpath
 mkdir $localpath
fi

cd $localpath

cmd="rm -f $serverlogpath/$logfile"
#ssh $serveruser@$serverip $rtcmd

echo "Start to copy db..."

#scp $serveruser@$serverip:$dbpath/* $localpath
#mkdir $localpath/mysql
#scp $serveruser@$serverip:$dbpath/mysql/* $localpath/mysql
#mkdir $localpath/ryengy
scp $serveruser@$serverip:$dbpath/ryengy/* $localpath/ryengy
#mkdir $localpath/performance_schema
scp $serveruser@$serverip:$dbpath/performance_schema/* $localpath/performance_schema

echo "DONE!!!"

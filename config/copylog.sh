#!/bin/sh

locallogpath=/g/HotCloud/logsfromali/test
serverip=47.92.123.34
serverlogpath=/usr/local/glassfish4/glassfish/domains/domain1/logs
logfile=server.log_2017-09-01T09-05-31
serveruser=root


if [! -d $locallogpath]; then
 mkdir $locallogpath
fi
cd $logpath
scp $serveruser@$serverip:$serverlogpath/$logfile $locallogpath

rtcmd="rm -f $serverlogpath/$logfile"
ssh $serveruser@$serverip $rtcmd
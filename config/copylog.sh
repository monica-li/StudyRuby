#!/bin/sh
# this is an example, which needs to be improved to use

locallogpath=/g/HotCloud/logsfromali/test
serverip=47.92.123.34
serverlogpath=/usr/local/glassfish4/glassfish/domains/domain1/logs
logfile=server.log_2017-09-01*
serveruser=root

if [ ! -d $locallogpath ]; then
 mkdir $locallogpath
fi
cd $logpath
scp $serveruser@$serverip:$serverlogpath/$logfile $locallogpath

rtcmd="rm -f $serverlogpath/$logfile"
ssh $serveruser@$serverip $rtcmd

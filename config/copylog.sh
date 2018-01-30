#!/bin/sh
# this is an example, which needs to be improved to use

locallogpath=/g/HotCloud/logsfromali/test
serverip=
serverlogpath=
logfile=server.log_2017-09-01*
serveruser=

if [ ! -d $locallogpath ]; then
 mkdir $locallogpath
fi
cd $locallogpath
scp $serveruser@$serverip:$serverlogpath/$logfile $locallogpath

rtcmd="rm -f $serverlogpath/$logfile"
ssh $serveruser@$serverip $rtcmd

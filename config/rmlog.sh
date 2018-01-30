#!/bin/sh
# this is an example, which needs to be improved to use

locallogpath=/g/HotCloud/logsfromali/test
serverip=
serverlogpath=
serveruser=

t_date=`date -d "-7 day" +%Y-%m-%d`
logfile="server.log_"$t_date"T*"
echo -n "Do you want to delete $logfile in server?(y/n) "
read confirm
if [ $confirm == y ]; then
  rtcmd="rm -f $serverlogpath/$logfile"
  ssh $serveruser@$serverip $rtcmd
  echo "Done!"
fi
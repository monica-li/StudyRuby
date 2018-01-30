#!/bin/sh
# This shell is used to backup mysql database
# at 2018-01-03 by monica-li

serverip=
serveruser=
mysqluser=
mysqlpwd=
mysqldb=

localdbbakpath=/g/HotCloud/dbbak/
#localdbbakpath=/Users/monica-li/hotcloud/StudyRuby/config
cd $localdbbakpath

time="$(date +"%Y%m%d%H%M%S")"
backupfile="$mysqldb"_"$time.sql"
rmpath=/usr/testgit/mysqlbak

echo "Start to export data..."
sshcmd="pushd $rmpath;mysqldump -u$mysqluser -p$mysqlpwd $mysqldb > $backupfile"
ssh $serveruser@$serverip $sshcmd

echo "Start to copy bak file to local..."
scp $serveruser@$serverip:$rmpath/$backupfile $localdbbakpath/$backupfile

echo "Clean the bak file in server"
sshcmd="pushd $rmpath;rm -f $backupfile"
ssh $serveruser@$serverip $sshcmd

echo "DONE!!!"

#!/bin/sh
installResult=1

productname="testprod"
version="1.1"
build="1.1.2"
distripath="/Users/monica-li/$productname/$version/$build"

productpath="/Users/monica-li/opt/$productname"
installfile="test.tar"

if [ ! -d "$productpath" ]; then
	mkdir $productpath
fi
if [ ! -d "$productpath/$version" ]; then
	mkdir $productpath/$version
fi
if [ ! -d "$productpath/$version/$build" ]; then
	mkdir $productpath/$version/$build
fi

pushd $productpath/$version/$build
tar zxvf $distripath/$installfile

configfile="configure.xml"
sed -i 's#baseDir="\${CATALINA_HOME}\/conf#baseDir="'$productpath'\/'$version'\/'$build'\/conf#' $configfile

export JAVA_HOME=/usr/bin/java
pushd $productpath/$version/$build/content/tomcat/bin
sh startup.sh
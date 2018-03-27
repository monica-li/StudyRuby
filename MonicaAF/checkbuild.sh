#!/bin/sh

productname="test"
version="1.1"
distripath="/Users/monica-li/$productname/$version"
runAFpath="/Users/monica-li/mygit/StudyRuby/MonicaAF"

buildlist="$runAFpath/buildlist.log"


pushd $distripath
newbuild=`ls -t | head -1`
cat $buildlist | grep $newbuild >/dev/null
if [ $? -eq 1 ]; then
    echo "there is a new file: $newbuild"
    echo $newbuild >> $buildlist
    popd $distripath
    pushd $runAFpath
    . ./runAF.sh -P $productname -V $version -B $newbuild
 else
	echo "no new file"
	popd $distripath
fi

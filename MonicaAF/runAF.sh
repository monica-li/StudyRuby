#!/bin/sh

# $# is used to get the arguments count of this script
# $0 is used to get current script file name.

#########################################################
# run this script as root user
# this script will invoke script installProduct.sh
# this script will invoke ruby scripts
#########################################################

if [ "$#" != 6 ]; then
  echo "$0 needs to be run with some arguments as follow:"
  echo "$0 -P productname -V version -B build"
  exit 1
fi

# $1 is used to get the 1st arg of this script
# get the input arguments
case $1 in
        -P) productname=$2
            ;;
        -V) version=$2
            ;;
        -B) build=$2
            ;;
        *) echo "please run as: $0 -P productname -V version -B build"
           ;;
esac

case $3 in
        -P) productname=$4
            ;;
        -V) version=$4
            ;;
        -B) build=$4
            ;;
        *) echo "please run as: $0 -P productname -V version -B build"
           ;;
esac

case $5 in
        -P) productname=$6
            ;;
        -V) version=$6
            ;;
        -B) build=$6
            ;;
        *) echo "please run as: $0 -P productname -V version -B build"
           ;;
esac

# invoke the installProduct.sh to deploy the testing environment
. ./installProduct.sh
echo "arg from installProduct.sh: $installResult"

# invoke ruby script
# $? is used to get the result of previous command
rspec test_spec.rb -f h -o rspec_result.html
if [ "$?" == 0 ]; then
  echo "test passed"
else
  echo "test failed"
fi
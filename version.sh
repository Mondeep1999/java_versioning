#!/bin/bash
set -ex

cd ../
branch=$(git rev-parse --abbrev-ref HEAD)
cd  java_versioning/

jar_count=$(cat version.txt| wc -l)
# echo $jar_count
if [ $jar_count == 0 ]; then
    i=1 && j=0 && k=0

else

    last_jar=$( cat version.txt )

    # echo $last_jar                   # jar-v1.0.5
    i=$(echo "$last_jar" | awk -F'[-.]' '{print $2}'| sed 's/[^0-9]*//g')
    # echo $i
    j=$(echo "$last_jar" | awk -F'[-.]' '{print $3}'| sed 's/[^0-9]*//g')
    # echo $j
    k=$(echo "$last_jar" | awk -F'[-.]' '{print $4}'| sed 's/[^0-9]*//g')
    # echo $k
    # name="$i$j$k"

    if [ $branch == "main" ]; then
        i=$( expr $i + 1 )

    elif [$branch == "dev" ]; then
          j=$( expr $j + 1 )

    elif [ $branch == "version" ]; then
          k=$( expr $k + 1 )

    else 
        echo " Please push in correct branch i.e. major/minor/subminor "
    fi


fi

cp -r /home/runner/work/java_versioning/java_versioning/app.release.txt .
mv app.release.txt app-v$i.$j.$k.txt

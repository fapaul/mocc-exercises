#!/usr/bin/env bash
source ./helper.sh

URL=$1

measurenginx()
{
    curl $URL > /dev/null &
    curl $URL > /dev/null
    wait
    echo $SECONDS
}
run measurenginx "nginx.csv"

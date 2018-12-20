#!/usr/bin/env bash
source ./helper.sh

measurefork()
{   
    start=100
    end=1000
    ./forksum $start $end
}
gcc -o forksum forksum.c 
run measurefork "fork.csv"
rm forksum

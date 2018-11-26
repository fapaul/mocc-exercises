#!/usr/bin/env bash
source ./helper.sh
source ./memsweep.sh

measuremem()
{
    # Collects memsweep and return single value to be consumed by helper, which calculates median
    # Result is taken from the last line
    result=$(memsweep >&1 | tail -1)
    echo $result
}
run measuremem "mem.csv"

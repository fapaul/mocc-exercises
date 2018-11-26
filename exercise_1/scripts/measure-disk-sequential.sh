#!/usr/bin/env bash
source ./helper.sh


measuresequential()
{
    # 
    dd if=/dev/zero of=/tmp/bench bs=250M count=1 oflag=direct > disk-sequential-temp >&1
    # Take last line of output file and then extract 10th argument (write/read speed)
    result=$(cat disk-sequential-temp | tail -1 | cut -d " " -f 10)
    echo $result
}
run measuresequential "results-measure-disk-seq.csv"

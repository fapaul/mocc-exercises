#!/usr/bin/env bash
source ./helper.sh

measurerandom()
{
    result=$(fio --name=randread --ioengine=libaio --iodepth=16 --rw=randread --bs=4k --direct=0 --size=1M --numjobs=1 --runtime=10 --group_reporting | grep -o -P '(?<=[Ii][Oo][Pp][Ss]=)[0-9]*')
    echo $result
}
run measurerandom "results-measure-disk-random.csv"

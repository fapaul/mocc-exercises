#!/usr/bin/env bash
source ./helper.sh

measuresequential()
{
    result=$(dd if=/dev/zero of=~/testfile bs=250M count=1 oflag=direct |& grep -o -P '(?<=s,\s).*(?=[MG]B)')
    echo $result
}
run measuresequential "results-measure-disk-seq.csv"

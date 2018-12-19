#!/usr/bin/env bash

cmds=("./measure-cpu.sh" "./measure-disk-random.sh" "./measure-fork.sh" "./measure-mem.sh"
)
for cmd in "${cmds[@]}"; 
do
    for i in {1..48}
    do
        $cmd
    done
done

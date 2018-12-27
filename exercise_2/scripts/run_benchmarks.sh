#!/usr/bin/env bash

cmds=("./measure-nginx.sh localhost:8080/test.nginx")
for cmd in "${cmds[@]}"; 
do
    for i in {1..48}
    do
        $cmd
    done
done

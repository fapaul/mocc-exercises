#!/usr/bin/env bash

./measure-cpu.sh && ./measure-disk-random.sh && ./measure-disk-sequential.sh && ./measure-mem.sh

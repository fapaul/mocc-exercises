#!/usr/bin/python3

import os
import sys
import subprocess

if __name__ == '__main__':
    if len(sys.argv) <= 1:
        print("Missing argument: <task>")
        exit(-1)

    task = sys.argv[1]
    if not task in ["ini", "map", "run"]:
        print("Error: Task {} not supported.".format(task))
        exit(-1) 

    pathname = os.path.dirname(os.path.realpath(__file__))
    script = pathname+'/'+task+'.py'
    subprocess.call([sys.executable, script] + sys.argv[2:])

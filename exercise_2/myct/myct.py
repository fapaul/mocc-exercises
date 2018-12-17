#!/usr/bin/python3

import os
import sys
import subprocess

if __name__ == '__main__':
    if len(sys.argv) <= 1:
        print("Missing argument: <task>")
        exit()

    pathname = os.path.dirname(os.path.realpath(__file__))
    task = sys.argv[1]
    script = pathname+'/'+task+'.py'
    subprocess.call([sys.executable, script] + sys.argv[2:])

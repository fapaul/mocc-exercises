import os
import sys
import subprocess
import argparse


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Maps files read only from the host system to the container')
    parser.add_argument('container_path', type=str, help='Container')
    parser.add_argument('host_path', type=str, help='Path inside host system')
    parser.add_argument('target_path', type=str, help='Path inside container')

    args = parser.parse_args()

    if not os.path.exists(args.container_path):
        print("Error: container path: {} does not exists.".format(args.container_path))
        exit(-1)

    if not os.path.exists(args.host_path):
        print("Error: host path: {} does not exists.".format(args.host_path))
        exit(-1)

    complete_target_path = os.path.join(args.container_path, args.target_path)

    try:
        if not os.path.exists(complete_target_path):
            os.makedirs(complete_target_path)
    except OSError:
        print ('Error: Could not create folder at {}. '.format(complete_target_path))        
        exit(-1)

    subprocess.call(["mount", "--bind" ,"-r", args.host_path, complete_target_path])
    
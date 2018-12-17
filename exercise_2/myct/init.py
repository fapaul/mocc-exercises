import os
import sys
import subprocess
import argparse


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='arboretum topology CLI')
    parser.add_argument('container_path', type=str, help='Container to create')

    args = parser.parse_args()

    if os.path.exists(args.container_path):
        print("Error: path: {} already exists.".format(args.container_path))
        exit(-1)

    print("Initialize container at: {}.".format(args.container_path))

    try:
        if not os.path.exists(args.container_path):
            os.makedirs(args.container_path)
    except OSError:
        print ('Error: Could not create folder at {}. '.format(args.container_path))        
        exit(-1)
    
    print("Debootstrap version: ")
    deboostrap = "debootstrap"
    subprocess.call([deboostrap, "--version"])
    
    print("Setup Debian inside container.")
    
    subprocess.call([deboostrap, "stable", args.container_path, "http://deb.debian.org/debian/"])
    
import os
import sys
import subprocess
import argparse


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Runs the file executeable in container with arguments')
    parser.add_argument('container_path', type=str, help='Container')
    parser.add_argument('--namespace', type=str, help='Namespace the executable runs in')
    parser.add_argument('--limit', type=str, help='Limits the ressources for the executable')
    parser.add_argument('executeable', type=str, help='Executable')
    args, executeable_args = parser.parse_known_args()

    if not os.path.exists(args.container_path):
        print("Error: container path: {} does not exists.".format(args.container_path))
        exit(-1)

    subprocess.call(["chroot", args.container_path, "mount", "-t", "proc", "proc", "/proc"])

    if not args.namespace:
        proc_mount_point = "{}/{}/proc".format(os.getcwd(), args.container_path)
        subprocess.call(["unshare", "-f", "-p", "--mount-proc={}".format(proc_mount_point),
            "chroot", args.container_path, args.executeable] + executeable_args)

    else:
        proc_mount_point = "{}/{}/proc".format(os.getcwd(), args.container_path)
        subprocess.call(["nsenter", "--pid=/proc/{}/ns/pid".format(args.namespace),
            "unshare", "-f", "--mount-proc={}".format(proc_mount_point),
            "chroot", args.container_path, args.executeable] + executeable_args)
    
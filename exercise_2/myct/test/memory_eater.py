import os

dumb = bytearray()

while True:
    dumb += bytearray(os.urandom(10000000))
    print("{}bytes".format(len(dumb)))
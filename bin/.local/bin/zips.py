#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# This file can be used alone or used in zips fish function

import os
import sys
import zipfile
import shutil
from subprocess import call
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-l', action='store', nargs='+', help='List the content of zip file')
parser.add_argument('-x', action='store', nargs='+', help='extract the zip file')
parser.add_argument('-c', action='store', nargs='+', help='create zip file')

for _, value in parser.parse_args()._get_kwargs():
    if _ in ('l', 'x') and value is not None:
        for file in value:
            print('')
            parent = 1
            with zipfile.ZipFile(file, "r") as zip:
                for info in zip.infolist():
                    try:
                        new_filename = info.filename.encode('cp437').decode('gbk')
                    except:
                        new_filename = info.filaname.encode('utf-8').decode('utf-8')

                    if _ == 'l':
                        print(new_filename, ',', info.file_size, 'bytes,', info.create_system, '(0=Windows,3=Unix)')
                    else:       # '-x'
                        # check if zip contain a parent dir or not
                        head, tail = os.path.splitext(file)
                        if head != new_filename.partition('/')[0]:
                            parent = 0

                        if tail == ".zip":
                            if parent == 0 and os.path.basename(os.path.normpath(os.getcwd())) != head:
                                if not os.path.exists(head):
                                    os.makedirs(head)
                                    shutil.copy2(file, head + "/")
                                    os.chdir(head)
                                    call(["zips.py", "-x", file])
                                    exit()

                        pathname = os.path.dirname(new_filename)
                        if not os.path.exists(pathname) and pathname!= "":
                            os.makedirs(pathname)

                        print('extracting: ' + new_filename)
                        data = zip.read(info.filename)
                        if not os.path.exists(new_filename):
                            fo = open(new_filename, "wb")
                            fo.write(data)
                            fo.close()

            if parent == 0:
                os.remove(file)
                os.chdir("..")
    elif _ == 'c' and value is not None:
        for dir in value:
            # delete the last slash if passing dir with one
            dir = dir.rstrip('/')

            file_paths = []

            # crawling through directory and subdirectories
            for root, directories, files in os.walk(dir):
                for filename in files:
                    # join the two strings in order to form the full filepath.
                    filepath = os.path.join(root, filename)
                    file_paths.append(filepath)

            head, tail = os.path.splitext(dir)
            if tail != ".zip":
                src = os.path.join(os.getcwd(), dir)
                dst = os.path.join(os.getcwd(), dir + '.zip')

            # writing files to a zipfile
            with zipfile.ZipFile(dst,'w') as zip:
                for file in file_paths:
                    zip.write(file)

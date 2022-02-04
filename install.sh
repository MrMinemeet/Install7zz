#!/bin/bash
# Copyright (c) 2022 Alexander Voglsperger | MrMinemeet

# File name for download and installation
FILE="7z2107-linux-x64.tar.xz"

# Download file
wget -O /tmp/$FILE https://www.7-zip.org/a/$FILE

# Unpack file
tar xf /tmp/$FILE -C /tmp

# Move file to /usr/local/bin
mv /tmp/7zz /usr/local/bin/
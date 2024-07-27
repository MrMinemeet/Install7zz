#!/bin/bash
# Copyright (c) 2022 Alexander Voglsperger | MrMinemeet

# File name for download and installation
FILE="7z2407-linux-x64.tar.xz"

# Download file
echo "Downloading $FILE"
wget -O /tmp/$FILE https://www.7-zip.org/a/$FILE

# Unpack file
echo "Unpacking file..."
tar xf /tmp/$FILE -C /tmp

# Move file to /usr/local/bin
echo "Installing 7zz"
mv -f /tmp/7zz /usr/local/bin/


echo "Installation complete!"

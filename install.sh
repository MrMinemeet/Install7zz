#!/bin/bash
# Copyright (c) 2022-2024 Alexander Voglsperger | MrMinemeet
# This script is licensed under the MIT license. See LICENSE file for more information.

# Check if script is run as root/with sudo
if [ $(id -u) -ne 0 ]
  then echo "Please run as root!"
  exit
fi

# Get latest version from 7-zip download page
version=$(curl -s https://www.7-zip.org | grep 'Download 7-Zip' | head -n 1 | sed 's/.*Download 7-Zip \([0-9]*\.[0-9]*\).*/\1/')
echo "Latest version: $version"

# Remove dot from version number to use for file name
fileVersion=$(echo $version | tr -d '.')

# File name for download and installation
FILE="7z$fileVersion-linux-x64.tar.xz"

# Download file
echo "Downloading $FILE"
wget -O /tmp/$FILE https://www.7-zip.org/a/$FILE

# Unpack file
echo "Unpacking file…"
tar xf /tmp/$FILE -C /tmp

# Move file to /usr/local/bin
echo "Installing 7zz…"
mv -f /tmp/7zz /usr/local/bin/

# Remove downloaded file
echo "Cleaning up…"
rm -f /tmp/$FILE

echo "Installation complete!"

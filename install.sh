#!/bin/bash
# Copyright (c) 2022-2025 Alexander Voglsperger | MrMinemeet
# This script is licensed under the MIT license. See LICENSE file for more information.

# Treat errors and unset variables as fatal. 
set -euo pipefail


# Check if script is run as root/with sudo
if [ $(id -u) -ne 0 ]
  then echo "Please run as root!"
  exit 1
fi

# Get latest version from 7-zip download page
version=$(curl -s https://www.7-zip.org | grep 'Download 7-Zip' | head -n 1 | sed 's/.*Download 7-Zip \([0-9]*\.[0-9]*\).*/\1/')
if [ -z "$version" ]; then
  echo "Error: Could not determine the latest 7-Zip version."
  exit 1
fi
echo "Latest version: $version"

# Remove dot from version number to use for file name
fileVersion=$(echo $version | tr -d '.')

# Determine system architecture
echo "Determining system architecture..."
arch_raw=$(uname -m)
arch_7zip=""

case $arch_raw in
  x86_64 | amd64)
    arch_7zip="x64"
    ;;
  i386 | i686)
    arch_7zip="x86"
    ;;
  aarch64 | arm64)
    arch_7zip="arm64"
    ;;
  armv7l | armhf | arm) # armv7l is common for 32-bit ARM, armhf for hard-float
    arch_7z="arm"
    ;;
  *)
    echo "Unsupported architecture: $arch_raw"
    echo "7-Zip officially supports x64, x86, arm64, and arm for Linux."
    exit 1
    ;;
esac

echo "Detected architecture: $arch_raw (mapped to 7-Zip arch: $arch_7zip)"

# File name for download and installation
FILE="7z$fileVersion-linux-${arch_7zip}.tar.xz"

# Download file
echo "Downloading $FILE"
if ! wget --progress=bar:force -O "/tmp/$FILE" "https://www.7-zip.org/a/$FILE"; then
    echo "Error: Download failed for $FILE."
    echo "Please check if the version $version and architecture $arch_7zip combination is available on https://www.7-zip.org/download.html"
    rm -f "/tmp/$FILE" # Clean up partial download
    exit 1
fi

# Unpack file
echo "Unpacking file…"
if ! tar xf "/tmp/$FILE" -C /tmp; then
    echo "Error: Failed to unpack $FILE."
    rm -f "/tmp/$FILE" # Clean up downloaded archive
    exit 1
fi

# Check if 7zz binary exists in unpacked files
if [ ! -f "/tmp/7zz" ]; then
    echo "Error: 7zz binary not found in the unpacked archive."
    echo "The archive might have a different structure or the wrong file was downloaded."
    rm -f "/tmp/$FILE" # Clean up downloaded archive
    exit 1
fi

# Move file to /usr/local/bin
echo "Installing 7zz to /usr/local/bin/ ..."
if ! mv -f /tmp/7zz /usr/local/bin/; then
    echo "Error: Failed to move 7zz to /usr/local/bin/."
    echo "Check permissions or if /usr/local/bin is writable."
    rm -f /tmp/7zz # Clean up unpacked binary
    rm -f "/tmp/$FILE" # Clean up downloaded archive
    exit 1
fi

# Make it executable (tar usually preserves permissions, but just in case)
chmod +x /usr/local/bin/7zz

# Remove downloaded file
echo "Cleaning up…"
rm -f /tmp/$FILE

echo "Installation of 7-Zip $version for $arch_7zip complete!"
echo "You can now use '7zz' command."
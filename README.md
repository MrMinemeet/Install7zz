> [!IMPORTANT]
> Some distributions already deliver the official 7-Zip package under names such as `7zip`. Please use such versions of your distribution if possible, to get updates automatically.

# Description
Script to install the official 7-Zip (64-bit Linux x86-64) from https://www.7-zip.org/  
The latest version is automatically fetched from the official website and used for the installation.

# How to install?
Clone and then run the script as root, it should do the downloading, unpacking and installing for you

**Don't know how to run a script?**  
Well… first make sure it can be executed like this:
`sudo chmod +x ./install.sh`
after this start the script as root:
`sudo ./install.sh`

**Can't you do that for me?**   
Well with this command it's basically copy and paste  
`sudo curl https://raw.githubusercontent.com/MrMinemeet/Install7zz/main/install.sh | sudo bash`

# Now how can I use it?
It's pretty similar to `7z` from the p7zip package, but instead you have to use `7zz` for the official one that you just installed

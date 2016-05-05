#!/bin/bash

#AUTHOR: Reprise
#DATE: 4.28.2016

#PURPOSE:
#This script moves the files of ytdl to the correct locatons, and changes the 
#permissions of the files in ~/Music so that users other than root can access them.
#root permissions are needed to write to /bin.
#This script installs ytdl v1.10.

#Version 1.01
#===================================================================================

FILE="/tmp/out.$$"
GREP="/bin/grep"
wd=$(pwd)

# Are we root?
if [[ $EUID -ne 0 ]]; then
      echo "This script must be run as root" 1>&2
      exit 1

#Yes? Install time.
else   
      #finding out what user we're installing to, since ~/ will return /home/root.
      me=$(readlink -f install.sh | cut -f3 -d '/')
      echo "Installing to user: '$me'"
      me=$(echo /home/$me)

      #Ok, here's the magic.
      echo "creating $me/Music/ytdl-downloads"
      mkdir $me/Music/ytdl-downloads

      echo "setting permissions for '$me/Music/ytdl-downloads'"
      chmod a+rwx $me/Music/ytdl-downloads

      echo "moving help page to $me/Music/ytdl-downloads"  
      cp ytdl-help.txt $me/Music/ytdl-downloads

      echo "Changing permissions for '$me/ytdl-downloads/ytdl-help.txt'"
      chmod a+rwx $me/Music/ytdl-downloads/ytdl-help.txt

      echo "moving ytdl to /bin"
      mv ytdl.sh ytdl
      cp ytdl /bin
      
      echo "changing permissions of 'ytdl.sh'"
      chmod a+rwx /bin/ytdl      
      mv ytdl ytdl.sh

      #ending message:
      tput setaf 2; echo -e "[ OK ] \c"
      tput sgr0   ; echo -e "Done!  Enjoy ytdl!"
fi

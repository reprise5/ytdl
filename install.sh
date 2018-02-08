#!/bin/bash

#AUTHOR: Reprise
#DATE: 4.28.2016

#PURPOSE:
#This script moves the files of ytdl to the correct locatons, and changes the
#permissions of the files in ~/Music so that users other than root can access them.
#root permissions are needed to write to /usr/bin.
#This script installs ytdl v1.10+.

#Version 1.3.1
#===================================================================================
opt=$1
case "$opt" in
      # RUN AS AN UPDATER (needs work)
      -u|--update)
            #need to be root for this too, because copying to /usr/bin.
            if [[ $EUID -ne 0 ]]; then
                  echo "This script must be run as root in order to write to /usr/bin." 1>&2
                  exit 1

            #Yes? Install time.
            else
                  #finding out what user we're installing to, since ~/ will return /home/root.
                  me=$(readlink -f install.sh | cut -f3 -d '/')
                  me=$(echo /home/$me)

                  #get files from github, then put the new copy of ytdl in place.
                  cd $me/Desktop
                  echo "Downloading..."
                  git clone https://github.com/reprise5/ytdl
                  cd ytdl

                  echo "Giving execute permissions to'ytdl.sh'"
                  chmod a+x ytdl.sh

                  # Won't work unless YTDL can be run as root.
                  installedVersion=$(ytdl --version | cut -d ' ' -f 3)
                  thisVersion=$(./ytdl.sh --version)
                  echo "installedVersion: $installedVersion thisVersion $thisVersion"

                  if [[ thisVersion != installedVersion ]]; then
                        echo "moving ytdl.sh to /usr/bin..."
                        cp ytdl.sh /usr/bin
                        mv /usr/bin/ytdl.sh /usr/bin/ytdl
                  fi

                  cd ..
                  rm -rf ytdl
            fi

            if [ -t 1 ]; then
                  tput setaf 1; echo -e "[ !! ] \c"
                  tput sgr0   ; echo -e "There was an error while updating ytdl."

            else
                  tput setaf 2; echo -e "[ OK ] \c"
                  tput sgr0   ; echo -e "UP-TO-DATE"
            fi
            ;;
      # RUN AS AN INSTALLER. (first time install)
      *)
            # Are we root?
            if [[ $EUID -ne 0 ]]; then
                  echo "This script must be run as root in order to write to /usr/bin." 1>&2
                  exit 1

            #Yes? Install time.
            else
                  # Finding out what user we're installing to, since ~/ will return /home/root.
                  me=$(readlink -f install.sh | cut -f3 -d '/')
                  me=$(echo /home/$me)

                  #Ok, move files and set correct permissions.
                  echo "creating $me/Music/ytdl-downloads"
                  mkdir $me/Music/ytdl-downloads

                  echo "setting permissions for '$me/Music/ytdl-downloads'"
                  chmod a+rwx $me/Music/ytdl-downloads

                  echo "moving ytdl & playlist to /usr/bin"
                  mv ytdl.sh /usr/bin/ytdl
                  mv playlist.py /usr/bin/playlist

                  echo "Giving execute permissions to'ytdl.sh' and 'playlist.py'."
                  chmod a+x /usr/bin/ytdl
                  chmod a+x /usr/bin/playlist

                  #ending message:
                  tput setaf 2; echo -e "[ OK ] \c"
                  tput sgr0   ; echo -e "Done!  Enjoy ytdl!"
            fi
            ;;
esac

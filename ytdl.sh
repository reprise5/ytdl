#!/bin/bash

#AUTHOR: Reprise
#DATE: 4.28.2016

#PURPOSE:
#This script grabs a stream off youtube, then converts it to mp3.
#it assumes you have no other .m4a files in the dir.
#Syntax: ytdl [OPTIONS] [URL]  *an option is required.

#Version: 1.10
#===================================================================================

get_stream() {
      #check Youtube-dl's existence =======
      if [ -f /usr/bin/youtube-dl ]; then 
            youtube-dl --extract-audio -f 140 $URL  -o '%(title)s.%(ext)s' --restrict-filenames 
      else
            echo "please install youtube-dl to grab this stream."
            exit 0
      fi
      
      #Check if youtube-dl made a .m4a file, and quit if there isn't one.
      unconverted=$(ls | grep *.m4a)
      if [ "$unconverted" = "" ]; then
            #Download Failed from youtube-dl.
            tput setaf 1; echo -e "[ERROR] \c"
            tput sgr0   ; echo -e "Download failed from ytdl. \nAborting...\n"
            exit 0
      else
            #Youtube-dl successfully grabbed the stream.
            echo -e "\nOutput: '$wd/$unconverted'"
      fi
      
      #prepare Standard Input =======
      #chop off the .m4a extension so we can append ".mp3" for use of an output name.
      #then add underscores to the in and outfile for avconv's standard input requirement.
      filename1=$(echo $unconverted | rev | cut -f 2- -d '.' | rev)
      outfile=$(echo ${filename1// /_})
      outfile=$(echo $outfile.mp3)
      infile=$(echo $unconverted | cut -f1 -d' ')
}

conv_stream() {
      if [ -f /usr/bin/avconv ]; then 
            tput setaf 3; echo -e "converting to MP3...\n"
            tput sgr0   ; 
            avconv -i $infile $outfile
      else
            echo "please install avconv to convert this stream."
            exit 0
      fi  
}

display_help() {
            cat ~/Music/ytdl-downloads/ytdl-help.txt
}

opt=$1
URL=$2

#Are you root?
if [ "$EUID" -eq 0 ]
  then echo "Please don't run this as root."
  exit
fi

#Check if ~/Music/ytdl-downloads exists.  It's the working directory.
cd ~/Music
if [ -d ~/Music/ytdl-downloads ]; then
      cd ytdl-downloads 
      wd=$(pwd)  
else
      echo "creating '~/Music/ytdl-downloads...'"
      mkdir ytdl-downloads
      cd ytdl-downloads
      wd=$(pwd)
fi

case "$opt" in
      -u|--url)
            if [[ -n $URL ]]; then
                  get_stream "$URL"
            else
                  echo -e "Please enter a valid URL."
                  exit 0
            fi

            if [ "$unconverted" = "" ]; then
                  #if unconverted isn't there:
                  tput setaf 1; echo -e "[ERROR] \c"
                  tput sgr0   ; echo -e "The raw stream went missing or doesn't exist in '$wd'.\n"
            else
                  conv_stream $infile $outfile 
                  rm "$unconverted"
                  tput setaf 2; echo -e "[ OK ] \c"
                  tput sgr0   ; echo -e "Download complete.\n       Output: $wd/$outfile"
            fi
            ;;
      -k|--keep-original)
            #if you wanna keep the original .m4a
            echo "'Keep original' logic to come."
            ;;
      *|-h|--help)
            display_help
            ;;
esac

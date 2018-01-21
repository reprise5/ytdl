#!/bin/bash

#AUTHOR: Reprise
#DATE: 10.5.2017

#PURPOSE:
#This script grabs a stream off youtube, then converts it to mp3.
#it assumes you have no other .m4a files in the dir.
#Syntax: ytdl [OPTIONS] [URL]  *an option is required. Argument isn't.

#Version: 1.3.3
#===================================================================================
VERSION="1.3.3"   #Variable holds the version.  when updating, change it here.
opt=$1            #first option, which should be -u, -v, or -h.
URL=$2            #arguement to go with option1, namely -u.
opt2=$3           #option 2, reserved only for -t at this time.
ME=$(echo ~/)     #home directory
infile=""         #filename with underscores for avconv's standard input requirement
outfile=""        #as above, but the output name while callling avconv
TITLE=""          #for writing ID3 tags.  user inputs, taken in with read statements.
ARTIST=""         #for writing ID3 tags.  user inputs, taken in with read statements.

display_help() {
    cat << EOF
Usage: $0 OPTION ['URL'][-t] or
          -t [FILENAME]

  ****************************************************************************************
  *This script is intended to Grab a stream off of youtube using youtube-dl, and then    *
  *Take that file and convert it to an mp3 using avconv.  it will delete the             *
  *file after it has been converted.  To update this script simply clone it from github: *
  *git clone https://github.com/reprise5/ytdl/                                           *
  *                                                                                      *
  *For information about the programs used in this script see these links:               *
  *AVCONV:     https://libav.org/                                                        *
  *YOUTUBE-DL: https://github.com/rg3/youtube-dl                                         *
  ****************************************************************************************

OPTIONS:
      --version         Displays which version of ytdl this is.

      -u, --url [URL]   will download and convert a YouTube stream normally.
                        The output goes to ${ME}Music/ytdl-downloads.

      -t, --mktag       Gives you the option to write title and artist ID3 Tags.  will also rename
                        the filename with the information you give.  do not give null values.
                        SYNTAX: ytdl -u 'URL' -t or ytdl -t filename.mp3.
                        will only change tags for music in ytdl-downloads folder.

      -l, --list        List the music youve already downloaded with ytdl.  Music resides
                        in ~/Music/ytdl-downloads.
      --playlist        Creates a playlist in ${ME}Music/ytdl-downloads.  if you specify
                        a path as an arguement, a playlist will be made there instead.

      -h , --help       Display this help menu.
EOF
}

get_stream() {
      #check Youtube-dl's existence
      if [[ -f /usr/local/bin/youtube-dl || -f /usr/bin/youtube-dl ]]; then
            youtube-dl --extract-audio -f 140 $URL  -o '%(title)s.%(ext)s' --no-playlist --restrict-filenames
      else
            echo "please install youtube-dl through python-pip to grab this stream."
            exit 1
      fi

      #Prepare the standard input.
      unconverted=$(ls | grep *.m4a)
      if [ "$unconverted" = "" ]; then
            #Download Failed from youtube-dl.
            tput setaf 1; echo -e "[ERROR] \c"
            tput sgr0   ; echo -e "Download failed. exiting early.\n"
            exit 1
      else
            #Youtube-dl successfully grabbed the stream.
            echo -e "\nOutput: '$wd/$unconverted'"
      fi

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
            echo "please install the package 'libav-tools' to convert this stream."
            exit 1
      fi
}

make_ID3_tags() {
      if [ -f /usr/bin/eyeD3 ]; then
            cd cd ~/Music/ytdl-downloads
            tput setaf 2; echo -e "Writing Basic ID3 Tags for SONG-TITLE and ARTIST."
            tput sgr0   ; echo -e "TITLE:\c"
            read "TITLE"
            echo -e "ARTIST:\c"
            read  "ARTIST"

            #Write the ID3 Tags out with eyeD3.
            eyeD3 -t "$TITLE" -a "$ARTIST" $outfile
            #implicit rename. Hard-coded extension appended to ARTIST.
            ARTIST=$(echo ${ARTIST}.mp3)
            mv $outfile "$TITLE - $ARTIST"
      fi
}
#Are you root?
if [ "$EUID" -eq 0 ]
      then echo "Please don't run this as root."
      exit 0
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

#Currently, if both options are to be read, must go -u then -t.  not -t then -u.
#I don't know how to use getopts.  ;(

case "$opt" in
      -u|--url)
            #check $URL for formatting/existence.
            if [[ $URL == *"&list="* ]]; then
                  echo "this URL points to a playlist.  Taking current video."
                  #Parse text & take URL up to first "&" at "&list=" which points to playlist.
                  URL=$(echo $URL | awk 'BEGIN { FS="&" } /1/ { print $1 }')
                  get_stream "$URL"\c
            elif [[ -n $URL ]]; then
                  get_stream "$URL"\c
                  #echo "Stream does not contain \"&list=\"." 
            else
                  echo -e "Please enter a valid URL."
                  exit 0
            fi

            #look for unconverted and process if unconverted file is there.
            if [[ "$unconverted" == "" ]]; then
                  tput setaf 1; echo -e "[ERROR] \c"
                  tput sgr0   ; echo -e "The raw stream went missing or doesn't exist in '$wd'.\n"
            else
                  conv_stream $infile $outfile
                  rm "$unconverted"
                  tput setaf 2; echo -e "[ OK ] \c"
                  tput sgr0   ; echo -e "Download complete.\n       Output: $wd/$outfile"
            fi

            #so that -u and -t can be used at the same time.
            case "$opt2" in
                  -t|--mktag)
                        make_ID3_tags
                   ;;
            esac
            ;;
      -t|--mktag)
            #this only changes tags for stuff in ytdl-downloads.
            #Make_ID3_tags changes directories to ytdl-downloads before begining.
            outfile=$2
            echo "outfile is $outfile."
            make_ID3_tags
            echo "artist: $ARTIST , Title: $TITLE"
            ;;
      --version)
            echo "Version: " $VERSION
            ;;
      -l|--list)
            cd ~/Music/ytdl-downloads/
            echo -e "\n        >>>>>]DOWNLOADED FILES[<<<<<"
            ls -lAh | awk '{$1=$2=$3=$4=$6=$7=$8=""; print $0}'
            ;;
      -p|--playlist)
            #if it's zero length, use ytdl-downloads by default. otherwise use user's path.
            if [ -z $2 ]; then
                  playlist ~/Music/ytdl-downloads/
            else
                  playlist $2
            fi

            ;;
      *|-h|--help)
            display_help
            ;; # .
esac #            \__.-'
#                /o0 |--.--,--,--. 
#                \_.,'Y_|T_|D_|L_'  Blob Jr.
#                  `   """"""""" 


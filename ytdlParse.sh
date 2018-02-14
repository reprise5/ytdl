#!/bin/bash

#AUTHOR: Reprise
#DATE: 2018.01.20
#      yyyy/mm/dd

#PURPOSE:
#This is used to debug parsing of URL in YTDL.
#Tab witdh here is 4.  tab width 6 in ytdl.

#Version: 1.3.3

URL=$1           

if [[ $URL == *"&list="* ]]; then
    echo "this URL points to a playlist.  Taking current video."
    #Parse text & take URL up to first "&" being "&list=" which points to playlist.
    URL=$(echo $URL | awk 'BEGIN { FS="&" } /1/ { print $1 }')
    echo "URL is $URL"

elif [[ -n $URL ]]; then
    #get_stream "$URL"\c
    echo "Stream does not contain \"&list=\"." 
else
    echo -e "Please enter a valid URL."
    exit 0
fi


#                              Sample Output
#┌─(~/Desktop/ytdl)─────────────────────────────────────(reprise@Enkidu:pts/0)─┐
#└─(16:59:47─> ./ytdlParse.sh AA&BB                        127 ↵ ──(Sat,Jan20)─┘
#[1] 25118
#zsh: command not found: BB
#Stream does not contain "&list=".                                                                           
#┌─(~/Desktop/ytdl)─────────────────────────────────────(reprise@Enkidu:pts/0)─┐
#└─(17:00:57─>                                             127 ↵ ──(Sat,Jan20)─┘
#[1]  + done       ./ytdlParse.sh AA


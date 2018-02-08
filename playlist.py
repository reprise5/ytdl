#!/usr/bin/python3
'''
AUTHOR: Reprise
DATE: 05.18.17
Version: 1.0.2

PURPOSE:
This program is meant to create .m3u entries to assist in the creation of playlists.
It is meant to be called from 'ytdl.sh', which will give it a path as an argument.
the path should be where the playlist is to be created.
'''

import os
import sys
import re
from mutagen.mp3 import MP3

FORMAT_DESCRIPTOR = "#EXTM3U"
FILE_MARKER = "#EXTINF"
PATH = sys.argv[1]  # This should be given by ytdl.
filename = "DATA.m3u"

# Check for path in which to find files to make into a playlist.
if len(sys.argv) < 2:
    print("Invalid path to directory.")
    exit(0)

# Create, open, and set header for playlist file.
playlist = open(filename, 'w')
playlist.write(FORMAT_DESCRIPTOR + "\n\n")

for track in os.listdir(PATH):
    path_track = PATH + "/" + track

    # DATA.m3u will be in this directory, we don't want to process it.
    if track != filename:

        # Write entry as it should appear in playlist
        playlist.write(FILE_MARKER + ":")

        # Write RUNTIME
        audio = MP3(path_track)
        runtime = audio.info.length
        playlist.write(str(runtime)[0:3])
        playlist.write("," + track + "\n")

        # write path.
        playlist.write(path_track + "\n")
        print("entry created: " + track)

playlist.close()

# TODO : Do not record paths from root dir. If this walks into sub-folders, start recording path from cwd.
# TODO : Find music in recursive directories (walk), and understand their path from argv[1] Dir. 

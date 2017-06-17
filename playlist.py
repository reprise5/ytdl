#!/usr/bin/python3
'''
AUTHOR: Reprise
DATE: 05.18.17
Version: 1.0.0

PURPOSE:
This program is meant to create .m3u entries to assist in the creation of playlists.
While this program does not allow a user-specified ordering, the user can take the entries
and order them themselves.  it is meant to be called from 'ytdl' which will give it a path as an argument.
the path should be where the playlist is to be created.
'''

import os
import sys
import re
from mutagen.mp3 import MP3

if len(sys.argv) < 2:
    print("Invalid path to directory.")
    exit(0)

FORMAT_DESCRIPTOR = "#EXTM3U"
FILE_MARKER = "#EXTINF"
PATH = sys.argv[1]  # This should be given by ytdl.
filename = "DATA.m3u"

playlist = open(filename, 'w')
playlist.write(FORMAT_DESCRIPTOR + "\n\n")

for track in os.listdir(PATH):
    path_track = PATH + "/" + track

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

# TODO : The directory this program is run in should be the ROOT music directory.  The goal was not to have absolute paths.
# TODO : Find music in recursive directories, and understand their path from the root folder, being argv[1]. (walk?)

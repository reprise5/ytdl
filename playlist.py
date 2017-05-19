#!/usr/bin/python3
'''
AUTHOR: Reprise
DATE: 05.18.17

PURPOSE:
This program is meant to create .m3u entries to assist in the creation of playlists.
While this program does not allow a user-specified ordering, the user can take the entries
and order them themselves.

Version: 1.0.0
'''

import os
from mutagen.mp3 import MP3

FORMAT_DESCRIPTOR = "#EXTM3U"
FILE_MARKER = "#EXTINF"
PATH = '/home/reprise/Music/ytdl-downloads'
filename = "DATA.m3u"

playlist = open(filename, 'w')
playlist.write(FORMAT_DESCRIPTOR + "\n\n")
                        #os.getcwd()
for track in os.listdir(PATH):
    path_track = PATH + "/" + track

    #Write entry as it should appear in playlist
    playlist.write(FILE_MARKER + ":")

    # Write RUNTIME
    audio = MP3(path_track)
    runtime = audio.info.length
    playlist.write(str(runtime)[0:3])
    playlist.write("," + track + "\n")

    #write path.
    playlist.write(path_track + "\n")

playlist.close()

# Left to do: The directory this program is run in should be the ROOT directory, and any music
# Found in subdirectories should have a path. The goal was not to have absolute paths.


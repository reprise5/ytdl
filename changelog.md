```
                                  ██╗   ██╗████████╗██████╗ ██╗
                                  ╚██╗ ██╔╝╚══██╔══╝██╔══██╗██║
                         █████╗    ╚████╔╝    ██║   ██║  ██║██║      █████╗
                         ╚════╝     ╚██╔╝     ██║   ██║  ██║██║      ╚════╝
                                     ██║      ██║   ██████╔╝███████╗
                                     ╚═╝      ╚═╝   ╚═════╝ ╚══════╝                                                      
```
## [1.0.0] - 2016-04-20
`commit 6b1278349426274e1b3de709197055a818eabe3c`

Initial release

## [1.0.1] - 2016-04-20
#### Changed
- Changed the ordering of the commands for readability.
- Changed comments

#### TODO:
- Options, and pass URL as an arguement.
- Split up the code so it can be called from subroutines to make it into a case structure.  for options.     

## [1.0.2] - 2016-04-21
#### Added
- Added colors for [ OK ] , [ERROR] and "converting..." messages in the output.
- Added more conditional statements to handle more errors and problems, and better tell the user what's wrong.
- Added newline characters in echo to reduce filesize.
- Added a printed path to output (working directory) when displaying the filename when done.

#### Changed
- Separated youtube-dl & avconv calls into functions.
  - Split up the code so it can be called from subroutines to make it into a case structure for options.
- User puts URL on the same line as the message now.  Not a new line.
  - However it is still not passed as an arguement.  Using a read statement still.

#### TODO:
- Options, and pass URL as an arguement.
- Make case structure for passing arguements with options.

## [1.0.3] - 2016-04-26
`commit 9b0adad3e2994fa6fbf99e6aa1824cb9ad719277`

#### Changed
- Can now pass the URL as an arguement when running the script
- Echo syntax using ""
#### Added
- Make a seperate folder called "ytdl-downloads" If it doesn't exist already.  Make it the default Download location.
  - In order to go around the *.m4a issue that may arise from other people having those files in `~/Music`.

#### TODO:
- use getopts and make options to pass as well as the arguement.
    - Let format be [OPTIONS] [ARGUEMENT(S)].
    - One of these options will be mktag, which will be a new subroutine.
    - Use all of the standard opts like -h --help, &etc.
    - Edit the readme.
## [1.1.0] - 2016-04-28
`commit 33751e72970d842ad5c1c376445c65e2f877a754`
#### Added
- Added a case structure that allows the user to pass options AND arguements!
    - Currently `-h (help)`, `-u [url] (normal processing)`, and `-k --keep-original [url]` (keeps original *.m4a file after processing.)
- Checks if the user is root.  If they are the script won't run.
- Added `get_help()` functon.
- Added a `--help` page.  It's a seperate file that the script calls using cat. In the `get_help()` function.
- Added an installer that requires root to run.
    - Checks who it should install to
    - Makes ytdl-downloads folder in ~/Music, puts ytdl-help.txt in it.
    - Puts ytdl.sh in /bin without the extension
    - Changes permissions to the items made in ~/Music because root made them originally.
#### Changed
- Moved the pre-avconv code in the get_stream() function.  
    - The code that looks for unconverted, cuts the extension off it, and adds underscores.

#### TODO:
- Add more Options
- Finish -k option
- Add options that allow the user to chose converted filetype.  We'd just change how we call avconv, no big deal.  Only have to complely change how conv_stream() works.
- Maybe have the wildcard (*) option in the case perform regular processing instead of -u.  So the user can just call ytdl [URL] with no opts.

## [1.1.1] - 2016-09-29
`commit 4e2364e3e5cc0b5206a5850bc740ed71b1bfe094`
#### Fixed
- Color changed back to normal after "converting to MP3" Message
- Help Text such as usage and avconv/youtube-dl info is no longer printed to the screen using cat from a file. The text is inside the script, which eliminates the need for ytdl-help.txt.
- Version option `--version` was added.  Echoes a variable `$VERSION`.

## [1.1.2] - 2016-10-19
`commits e9d5ca855c8e4bf6a527d5613c2ba0f83aabb2ee, 994182489233a0c20df381af6361a18a578bb1ff`

#### Removed
- Removed Get_multi_stream() function.

#### Changed
- Changed Variable print in echo statement:
	- `$ME Music/ytdl-downloads` to `${ME}Music/ytdl-downloads`
    - This ^ used to have the output /home/user/ Music/ytdl-downloads, and now has the output /home/user/Music/ytdl-downloads.


## [1.2.0] - 2016-10-20
`commit 6d7e6f12d03c2158323aee1aa08749f5ca05b740`

#### Added
- After normal processing takes place in `-u`, and `-t` option is appended, then ID3 Tags sub will be invoked.  it will prompt the user for TITLE and ARTIST only.
	- Uses read statements right now.
    - If eyeD3 is not present, prompts the user if they would like to install it right there. If they say yes, it will use python pip.
    - The bones are there to just call ytdl -t filename.mp3 to invoke the make_ID3_tag sub and write tags if you changed your mind after processing.  still Work in progress.
- Looks at the URL to see if it points to a playlist on YouTube.  if it does, it tells the user
       the issue and quits itself.  
	- YTDL cannot handle multiple .m4a files in the same dir.  this prevents this from happening by accident. the pattern is "\*&list=\*".

#### TODO:
- Change installer to prompt user to install avconv, ytdl, and eyeD3 and do so as directed instead of the main ytdl script handling that.  Split the jobs.
- Multi_stream() function to GET using "\*&list=\*" URLs, and storing the NAMES in an array. when it is time to process, it pulls the first name in the array by ELEMENT not by .m4a, and assign it to $unconverted variable.  It's literally the perfect idea.
- How will -t work in this sense???  
	- If you learn getopts?
## [1.2.1] - 2017-03-25

#### Added
- Added ability to add ID3 tags. Uses read statements and prompts for artist & title.
	- Writing ID3 tags inplicitly renames file using the above information.
## [1.2.2] - 2017-05-08

#### Added
- File listing is available with the option `-ls` or `--list`.  Specifies the file size in Megs, as well as the name of the file right next to it.

#### Removed
- Removed prompts that try to install eyed3 through pip.

## [1.3.0] - 2017-06-23
`commit 0c49ef7fb08b92fcf04af8a3a17696acd9cfe6ff`
- Merged testing branch with master.  Below changes are functional.

#### Added
- Added the ability to create .m3u playlist entries from a python script "playlist.py".
	- Playlist.py is called from ytdl and can recieve a specific path to be sent to playlist.py for it to create entries in that specific directory.  If no directory is specified, ytdl will just send over ~/Music/ytdl-downloads as a default.
	- Skips procesing of the .m3u file it creates.  Can only process MP3 files now.

#### TODO:
- Walk into subdirectories.
	- Skip by extension.
    - Be able to process .ogg, .flac, and .wav files as well as just .mp3.  Do this by checking the extension to determine which mutagen mod to use.
    - Do not include full path in m3u entries. if it walks into a subdir, then start tracking paths.

## [1.3.1] - 2017-08-17
`commit 3a41af76e7819976cc70bbde6c840fbe1dbb289f`
#### Fixed
- Print file marker exclusively when a record is being written. (oversight).

## [1.3.2] - 2017-10-5

#### Changed
- Check for youtube-dl file in both /usr/bin and /usr/local/bin.
- Clarified error messages for missing dependencies.
	- avconv comes from libav-tools package.

#### TODO
- Dependency checks in installer script.
- Problems:
	- When installing to computers running different languages, ~/Music was not a destination for example. Maybe if non-english, put ytdl-downloads in ~ instead.
	- with Different/newer versions of libav/ffmpeg, youtube-dl threw some errors about depricated features. (on its own, without options.) Did not throw errors from ytdl.

## [1.3.3] - 2018-01-20

#### Changed
- ytdl.sh
    - Parse $URL input to check for playlist, and take URL text up to the first "&" for current video.
        - this option in the if/else structure now calls get_stream().
    - changed -ls option to -l.  Updated in help text and case structure.
    - Drew Blob Jr.
- README
    - reflects changes in help text
    - chmod 775 changed to +x
    - all instances of /bin changed to /usr/bin

#### TODO
- Dependency checks in installer script.
- instead of avoiding youtube playlists, can you embrace it?

## [1.3.4] - 2018-02-13
`commit 7475a2de19d14aef66e3050acc0524c7ba0cfc25`
`commit `
`merge `

#### Fixed
- --mktag option uses its own mktag routine instead of trying to reuse the one used post-download in  what I call "normal processing" (downloading a stream, and converting.  certain variables populate this way.)
    - This change fixes issue #3.
    - this new routine uses local variables for title/artist, which are taken in as args instead of read statements like in "normal processing."

#### Added
 - checks for eyeD3's existence here because it's not going through make_ID3_tags() routine anymore.

#### TODO
- rewrite make_ID3_tags to be able to receive arguments the same way --mktag does.
- Dependency checks in installer script.
- Detect non-english computer and install ytdl correctly.

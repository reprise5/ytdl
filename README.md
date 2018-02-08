                                ____  ____  _________  ______   _____     
                               |_  _||_  _||  _   _  ||_   _ `.|_   _|    
                                 \ \  / /  |_/ | | \_|  | | `. \ | |      
                                  \ \/ /       | |      | |  | | | |   _  
                                  _|  |_      _| |_    _| |_.' /_| |__/ | 
                                 |______|    |_____|  |______.'|________|                                       

 [![GitHub release](https://img.shields.io/github/release/reprise5/ytdl.svg)](https://github.com/reprise5/ytdl/releases)

All this script does is use youtube-dl and avconv to download and convert a youtube video to an mp3.  It automatically stores in `~/Music/ytdl-downloads` by default.

ytdl assumes that there are no other *.m4a files in the working directory. Having other *.m4a files might have unintended effects, so that's why there's a seperate folder for this script.

## Installation

#### youtube-dl and avconv
Since this script uses youtube-dl and avconv programs developed by other people, you will need to download and install them before using this script. 

To download [avconv](https://libav.org/), you can get it from the default apt repositories: `sudo apt-get install libav-tools` 
To Download [youtube-dl](https://github.com/rg3/youtube-dl), you can download it with python-pip: `sudo pip install --upgrade youtube_dl`

#### ytdl.sh
NOTE: Installing ytdl.sh isn't required, it's only for convenience.  If you want to run it as-is, Jump down to part 2 in the usage section below.

###### install.sh
I've written an installer for ytdl.  All you need to do is open a terminal and follow these steps:

First log in as root by typing `su`, `sudo su`, or `sudo -i`.
go to your Desktop, clone this git repository, and move to that directory.
```
cd ~/Desktop
git clone https://github.com/reprise5/ytdl
cd ytdl
```
next change the permissions of install.sh, and run it.
```
chmod +x install.sh
./install.sh
```
And you're done!

###### Manual installation
If the script Did not work for you, You can do it manually.  First open a terminal, and download the files to your desktop:
```
cd ~/Desktop
git clone https://github.com/reprise5/ytdl 
```
Move to the new directory with the downloaded files, rename ytdl.sh to ytdl, and add permissions.
```
cd ytdl
chmod +x ytdl.sh
mv ytdl.sh ytdl
```
Then put a copy of the ytdl file to /usr/bin.
```
cp ytdl /usr/bin
```

## Usage
###### 1:
If you followed the previously mentioned steps for installing, simply run the script by typing `ytdl` and pass the URL as an arguement. For example: `ytdl -u 'https://www.youtube.com/ASDFGHJKL'`

ytdl has a few options:
```
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
```

###### 2:
If you don't want to put the file in /usr/bin you can just run it as-is.
Assuming you didn't follow the installation steps for ytdl above:
```
cd ~/Desktop
git clone https://github.com/reprise5/ytdl
cd ytdl
chmod +x ytdl.sh
```
And then run the script:
`./ytdl.sh -u 'https://www.youtube.com/ASDFGHJKL' -t
`

this will download a single youtube video stream, convert it to mp3, then ask you artist and title to rename and write ID3 tags.

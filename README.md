                            ____  ____  _________  ______   _____     
                           |_  _||_  _||  _   _  ||_   _ `.|_   _|    
                             \ \  / /  |_/ | | \_|  | | `. \ | |      
                              \ \/ /       | |      | |  | | | |   _  
                              _|  |_      _| |_    _| |_.' /_| |__/ | 
                             |______|    |_____|  |______.'|________|                                       

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
chmod 775 install.sh
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
chmod 775 ytdl.sh
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
  ytdl [OPTIONS][URL]
  
  -h, --help          Displays help Dialogue
  -u, --url           Will download and convert a YouTube stream as originally intended.
  -k, --keep-original This will keep both the originally downloaded *.m4a file and the converted *.mp3.
                      It will make a new folder: .../ytdl-downloads/originals.  if it's not there yet.
                      [not programmed yet]
```

###### 2:
If you don't want to put the file in /bin you can just run it as-is.
Assuming you didn't follow the installation steps for ytdl above:
```
cd ~/Desktop
git clone https://github.com/reprise5/ytdl
cd ytdl
chmod 775 ytdl.sh
```
And then run the script:
`./ytdl.sh -u 'https://www.youtube.com/ASDFGHJKL'`

`--help` won't work if you do it like this, so just open ytdl-help.txt yourself if you need it.

# ytdl

All this script does is use youtube-dl and avconv to download and convert a youtube video to an mp3.  It automatically stores in `~/Music/ytdl-downloads` by default.

ytdl assumes that there are no other *.m4a files in the working directory. Having other *.m4a files might have unintended effects, so that's why there's a seperate folder for this script.

##Installation

######youtube-dl and avconv
Since this script uses youtube-dl and avconv programs developed by other people, you will need to download and install them before using this script. 

To download [avconv](https://libav.org/), you can get it from the default apt repositories: `sudo apt-get install libav-tools` 
To Download [youtube-dl](https://github.com/rg3/youtube-dl), you can download it with python-pip: `sudo pip install --upgrade youtube_dl`

###### ytdl.sh

NOTE: Installing ytdl.sh isn't required, it's only for convenience.  If you want to run it as-is, Jump down to part 2 in the usage section below.

First open a terminal, and download the files to your desktop:
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
Then put a copy of the ytdl file to /bin.
```
cp ytdl /bin
```
##Usage
###### 1:
If you followed the previously mentioned steps for installing, simply run the script by typing `ytdl` and pass the URL as an arguement. For example: `ytdl 'https://www.youtube.com/ASDFGHJKL'`

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
`./ytdl.sh 'https://www.youtube.com/ASDFGHJKL'`

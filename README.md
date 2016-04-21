# ytdl

all this script does is use youtube-dl and avconv to download and convert a youtube video to an mp3.  It automatically stores in ~/Music by default. 

It assumes that there are no other *.m4a files in the working directory (~/Music by default).  Having other *.m4a files might have unintended effects. (such as the wrong file being converted. so the original unconverted file will get deleted at the end without being converted.)

##Installation

######youtube-dl and avconv
since this script uses [youtube-dl](https://github.com/rg3/youtube-dl) and avconv programs developed by other people, you will need to download and install them before using this script. to download avconv, you can get it from the default apt repositories, so a simple `sudo apt-get install libav-tools` is all you need.

###### ytdl.sh

first open a terminal, and download the files to your desktop:
```
cd ~/Desktop
git clone https://github.com/reprise5/ytdl 
```
move to the new directory with the downloaded files, rename ytdl.sh to ytdl, and add permissions.
```
cd ytdl
chmod 775 ytdl.sh
mv ytdl.sh ytdl
```
Then put a copy of the ytdl file to /bin.
```
cp ytdl /bin
```
NOTE: Installation isn't required, it's only for convenience to use it.  see next section.

##Usage
###### 1:
If you followed the previously mentioned steps for installing, simply run the script by typing `ytdl` without options or arguements.  You will provide the URL after you initiate the program.  I will try and add that kind of support.

###### 2:
If you don't want to put the file in /bin you can just run it as it is.
Assuming you didn't follow the installation steps, you can take these steps to run it as it is.
```
cd ~/Desktop/ytdl
chmod 775 ytdl.sh
./ytdl.sh
```








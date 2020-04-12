#!/bin/bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; # Installs brew
brew install ffmpeg python3 git; # Installs ffmpeg for the program, python3 for the program, and git for the jumpcutter
pip3 install pillow audiotsm scipy numpy pytube; # Installs all the libraries from the requirements.txt file

cd $(dirname "$0"); # Change directory to where the script is (Use cd locally is it has no effect)
echo $PWD; # Prints directory
git clone https://github.com/carykh/jumpcutter.git; # Gets the main file, the jumpcutter.py
cd jumpcutter; # Goes into the folder

printf '#!/bin/bash
cd $(dirname "$0");
clear;
echo The directory is:;
echo $PWD;
echo ;
echo Make sure the videos are in the same folder as of the file;
echo Make sure that you have no unnecessary videos in the folder;
echo The script only works with the following video files: MP4, MOV, M4A;
echo Make sure the temp folder does not exist or else the script will not work;
echo ;
echo To cancel this operation, use Control+C to stop;
read -p "Enter video format (press return for MP4): " format;
format=${format:-mp4}
Read -p "Extra parameters (optional): " params;
echo $params

for f in ./*.$format;
do python3 jumpcutter.py --input_file "$f""$params";
done;' > jumpcutter.command; # Writes the file to simplify
chmod 777 jumpcutter.command;

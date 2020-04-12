#!/bin/bash
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
params=${params:-"--silent_speed 999999 --frame_margin 2"}
echo $params

for f in ./*.$format;
do python3 ./jumpcutter.py --input_file "$f""$params";
done;

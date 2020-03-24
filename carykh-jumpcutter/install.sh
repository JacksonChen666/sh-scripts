#!/bin/bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)";
brew install ffmpeg python3;
pip3 install pillow audiotsm scipy numpy pytube;

cd $(dirname "$0");
echo "#!/bin/bash" >> jumpcutter.command;
echo "cd $(dirname \"$0\");" >> jumpcutter.command;
echo "clear;" >> jumpcutter.command;
echo "echo The directory is:;" >> jumpcutter.command;
echo "echo $PWD;" >> jumpcutter.command;
echo "echo ;" >> jumpcutter.command;
echo "echo Make sure the videos are in the same folder as of the file;" >> jumpcutter.command;
echo "echo Make sure that you don\\'t have any unnecessary videos in the folder;" >> jumpcutter.command;
echo "echo The script only works with the following video files: MP4, MOV, M4A;" >> jumpcutter.command;
echo "echo Make sure the temp folder does not exists or else the script won\\'t work;" >> jumpcutter.command;
echo "echo ;" >> jumpcutter.command;
echo "echo To cancel this operation, use Control+C to stop \\(Command+C does not work\\);" >> jumpcutter.command;
echo "read -p \"Enter video format (press return for MP4): \" format;" >> jumpcutter.command;
echo "format=${format:-mp4}" >> jumpcutter.command;
echo "Read -p "Extra parameters (optional): " params;" >> jumpcutter.command;
echo "echo $params" >> jumpcutter.command;
echo "" >> jumpcutter.command;
echo "for f in ./*.$format;" >> jumpcutter.command;
echo "do python3 jumpcutter.py --input_file "$f""$params";" >> jumpcutter.command;
echo "done;" >> jumpcutter.command;
echo "" >> jumpcutter.command;
echo "echo Done! Press enter to continue;" >> jumpcutter.command;
echo "read;" >> jumpcutter.command;

chmod 777 jumpcutter.command;
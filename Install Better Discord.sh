cd /Applications
if [[ -d "Better Discord.app" ]]
then
	echo "You have already installed it! Remove it to reinstall"
fi
if [[ ! -d "Better Discord.app" ]]
then
	echo "Duplicating Discord..."
	cp -r /Applications/Discord.app /Applications/Better\ Discord.app
	cd /Applications/Better\ Discord.app/Contents/Resources/
	if [[ -d "./app/" ]]
	then
		echo "Attempting to delete old app folder, please check the folder before deleting!"
		rm -r -v /Applications/Better\ Discord.app/Contents/Resources/app
	fi
	echo "Downloading..."
	curl -L -o injector.zip https://github.com/rauenzi/BetterDiscordApp/archive/injector.zip
	unzip injector.zip
	echo "Renaming..."
	mv ./BetterDiscordApp-injector/ ./app/
	echo "Cleaning up..."
	rm ./injector.zip
	echo "Opening application..."
	open -a "/Applications/Better Discord.app"
	echo "Well, guess i'm finished"
fi

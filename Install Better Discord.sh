#!/bin/bash
RED='\033[91m'
VERYRED='\033[31m'
BLUE='\033[34m'
PROGRESS='\033[38;5;247m'
GREEN='\033[92m'
RESET='\033[0m'
FILENAME='injector.zip'
OS=$(uname)
if [[ ! $OS == "Darwin" ]]
then
	echo -e "${RED}Unsupported system to install on. Manually install it or whatever.${RESET}";
	exit 0;
fi
cd /Applications
function installBD () 
{
	[[ ! -d "Discord.app" ]] && echo -e "${RED}Discord not found. Please make sure it is in the applications folder.${RESET}"; exit;
	[[ -d "Better Discord.app" ]] && rm -r /Applications/Better\ Discord.app
	echo -e "${PROGRESS}Downloading while doing other stuff${RESET}" &
	curl -L -o $FILENAME https://github.com/rauenzi/BetterDiscordApp/archive/injector.zip &
	echo -e "Duplicating Discord...${RESET}" &
	cp -r /Applications/Discord.app /Applications/Better\ Discord.app
	cd /Applications/Better\ Discord.app/Contents/Resources/
	if [[ -d "./app/" ]]
	then
		echo -e "${VERYRED}Attempting to delete old app folder, please check the folder before deleting!${RESET}" &
		rm -r -v /Applications/Better\ Discord.app/Contents/Resources/app
	fi
	while [ ! -f "/Applications/$FILENAME" ]; do sleep 0.1; done
	echo -e "${RESET}Installing...${PROGRESS}"
	mv /Applications/$FILENAME ./
	unzip $FILENAME
	mv ./BetterDiscordApp-injector/ ./app/
	echo -e "Cleaning up..."
	rm ./$FILENAME &
	echo -e "${GREEN}Finished, bye${RESET}";
	exit 0;
}
if [[ ! -d "Discord.app" ]]
then
	echo -e "${RED}Discord not found. Please make sure it is in the applications folder.${RESET}"
elif [[ -d "Better Discord.app" ]] && [[ -d "./Better Discord.app/Contents/Resources/app/" ]]
then
	echo -e "${RED}You have already installed it!${RESET}"
	echo -e "Would you like a ${VERYRED}complete${RESET} reinstall?"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) installBD;;
			No ) exit;;
		esac
	done
elif [[ -d "Better Discord.app" ]] && [[ ! -d "./Better Discord.app/Contents/Resources/app/" ]]
then
	echo -e "${RED}Seems like it wasn't properlly installed. Reinstalling...${RESET}"
	installBD
elif [[ ! -d "Better Discord.app" ]] && [[ -d "Discord.app" ]] && [[ ! -d "./Better Discord.app/Contents/Resources/app" ]]
then
	installBD
fi

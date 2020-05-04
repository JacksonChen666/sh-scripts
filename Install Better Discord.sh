#!/bin/bash
cd /Applications
RED='\033[91m'
VERYRED='\033[31m'
BLUE='\033[34m'
PROGRESS='\033[38;5;247m'
GREEN='\033[92m'
RESET='\033[0m'
if [[ -d "Better Discord.app" ]]
then
	echo -e "${RED}You have already installed it! Remove it to reinstall${RESET}"
fi
if [[ ! -d "Discord.app" ]]
then
	echo -e "${RED}Discord not found. Please make sure it is in the applications folder${RESET}"
fi
if [[ ! -d "Better Discord.app" ]] && [[ -d "Discord.app" ]]
then
	echo -e "Duplicating Discord...${RESET}"
	cp -r /Applications/Discord.app /Applications/Better\ Discord.app
	cd /Applications/Better\ Discord.app/Contents/Resources/
	if [[ -d "./app/" ]]
	then
		echo -e "${VERYRED}Attempting to delete old app folder, please check the folder before deleting!${RESET}"
		rm -r -v /Applications/Better\ Discord.app/Contents/Resources/app
	fi
	echo -e "${RESET}Downloading...${PROGRESS}"
	curl -L -o injector.zip https://github.com/rauenzi/BetterDiscordApp/archive/injector.zip
	echo -e "${RESET}Extracting...${PROGRESS}"
	unzip injector.zip
	echo -e "${RESET}Renaming folder..."
	mv ./BetterDiscordApp-injector/ ./app/
	echo -e "Cleaning up..."
	rm ./injector.zip
	echo -e "${GREEN}Well, guess i'm finished${RESET}"
fi

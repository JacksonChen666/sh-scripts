#!/bin/bash
# Use logname for first terminal login user
# "sudo -u $user whoami" is used to execute without root
oUser=$(logname)
function yesnoprompt() {
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) return 0;;
			No ) return 1;;
		esac
	done
}

function replaceInFile() {
    sed -i -e 's/${1}/${2}/g' "$3"
}

function checkCommandExists() {
	if [[ $(command -v $1) == *"$1"* ]]; then
		return 0
	else
		return 1
	fi
}


if [[ $EUID -ne 0 ]]; then
	exec sudo /bin/bash "$0" "$@"
fi
if [[ $(checkCommandExists apachectl ; echo $?) == 1 ]]; then
	echo "Apache(ctl) is not installed. oops!"
	apachectl stop
	launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd/plist
	if [[ $(checkCommandExists brew ; echo $?) == 1 ]]; then
		echo "Brew is not installed. ma main installer! Installing brew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JacksonChen666/sh-scripts/master/homebrew.sh)";
	fi
	sudo -u $oUser brew install apache2
	brew services start httpd
	sleep 3
	open http://localhost:8080
	echo "Does the webpage show \"It works\"?"
	if [[ $(yesnoprompt) == 1 ]]; then
		echo "ok... that's weird. lets just continue"
	fi
fi
cd /usr/local/etc/httpd
if [[ -f httpd.conf ]]; then
	replaceInFile "Listen 8080" "Listen 80" httpd.conf
	replaceInFile "DocumentRoot \"/usr/local/var/www\"" "DocumentRoot \"/Users/${oUser}/Sites\"" httpd.conf
	replaceInFile "<Directory \"/usr/local/var/www\">" "<Directory \"/Users/${oUser}/Sites\">s" httpd.conf
	replaceInFile "AllowOverride None" "AllowOverride All" httpd.conf
	replaceInFile "#LoadModule rewrite_module" "LoadModule rewrite_module" httpd.conf
	replaceInFile "User _www" "User ${oUser}" httpd.conf
	replaceInFile "Group _www" "Group staff" httpd.conf
	if [[ ! -d "/Users/${oUser}/Sites" ]]; then
		mkdir ~/Sites
	fi
	cd ~/Sites
	echo "<style>@media(prefers-color-scheme:dark){*{filter:invert(100%);}a:visited{color:#66f;}}.red{color:red;}</style><h1>Installation finished&#33;</h1><p>Your apache server has been setup has been finished. And if you see this message, it's working&#33;<br>The URL to your local (current network only) webpage is \"<a href='http://localhost' target='_blank'>http://localhost</a>\" (https won't work properly if not configured).<br>Now you can do whatever you want in /Users/your_username/Sites (replace your_username with \"your actual username\").<br><font class='red'>The index file has been deleted.</font> You will see your directory index on the next reload.<br><br>Installer made by <a href='https://github.com/JacksonChen666' target='_blank'>JacksonChen666</a></p>" > index.html
	apachectl -k restart
	sleep 1
	open http://localhost
	sleep 1
	rm index.html
fi
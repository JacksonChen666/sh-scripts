#!/bin/bash
read -p "What would you like to convert? " f
while read -n 1 -s -r -p 'Press any key to to continue'
do
	echo
	pyinstaller --noconfirm -F -w --add-binary='/System/Library/Frameworks/Tk.framework/Tk':'tk' --add-binary='/System/Library/Frameworks/Tcl.framework/Tcl':'tcl' "$f"
done
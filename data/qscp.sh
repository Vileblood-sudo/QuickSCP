#!/bin/bash  
cat <<EOF

   ____        _      _     _____  _____ _____  
  / __ \      (_)    | |   / ____|/ ____|  __ \ 
 | |  | |_   _ _  ___| | _| (___ | |    | |__) |
 | |  | | | | | |/ __| |/ /\___ \| |    |  ___/ 
 | |__| | |_| | | (__|   < ____) | |____| |     
  \___\_\\__,_|_|\___|_|\_\_____/ \_____|_|     
            2021 - Steven Thompson
EOF
DELAY=5
echo
read -p "Please input the IP Address:  " ipInput
read -p "Please input the username:  " usernameInput
read -p "Please input the port:  " portInput

while [[ "$REPLY" != 0 ]]; do
	clear
	cat <<-_EOF_
	Please select from the following options:

    1.) Copy a file to a remote system
    2.) Copy a file from a remote system
	
	_EOF_
  
	read -p "Enter your selection [1-2]> "
  
	if [[ "$REPLY" =~ ^[1-2]$ ]]; then
        if [[ "$REPLY" =~ ^[1]$ ]]; then
            echo "You have selected to copy a file to a remote system"
            echo
            read -p "Please input the path to file:  " filePath
            read -p "Please input the destination path:  " destinationPath
            scp -P $portInput $filePath $usernameInput@$ipInput:$destinationPath
            echo
            echo "Copy Successful"
            sleep $DELAY
        fi
        if [[ "$REPLY" =~ ^[2]$ ]]; then
            echo "You have selected to copy a file from a remote system"
            echo
            read -p "Please input the path to file:  " filePath
            read -p "Please input the destination path:  " destinationPath
            scp -P $portInput $usernameInput@$ipInput:$filePath $destinationPath
            echo
            echo "Copy Successful"
            sleep $DELAY
        fi
    fi
done
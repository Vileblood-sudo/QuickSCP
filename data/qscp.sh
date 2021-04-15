#!/bin/bash
clear
cat <<EOF

   ____        _      _     _____  _____ _____  
  / __ \      (_)    | |   / ____|/ ____|  __ \ 
 | |  | |_   _ _  ___| | _| (___ | |    | |__) |
 | |  | | | | | |/ __| |/ /\___ \| |    |  ___/ 
 | |__| | |_| | | (__|   < ____) | |____| |     
  \___\_\\__,_|_|\___|_|\_\_____/ \_____|_|     
            2021 - Steven Thompson
EOF
DELAY=3
echo
echo "Ensure SSH is open on connecting server"
echo
read -p "Please input the IP Address:  " ipInput
read -p "Please input the port:  " portInput
read -p "Please input the username:  " usernameInput

echo
echo "Checking if SSH is open.."
echo
echo > /dev/tcp/$ipInput/$portInput
if [ "$?" -ne 0 ]; then
    echo
    sleep $DELAY
    clear
    ./$(basename $0) && exit    
else
    echo "SSH is running!"
    sleep $DELAY
fi

while [[ "$REPLY" != 0 ]]; do
    clear
    echo "Target IP: $ipInput"
    echo "Target Port: $portInput"
    echo
	cat <<EOF
	Please select from the following options:

    1.) Copy a file to a remote system
    2.) Copy a file from a remote system
    3.) Change server data
    4.) Remote into server 
	
EOF
  
	read -p "Enter your selection [1-4]> "


	if [[ "$REPLY" =~ ^[1-4]$ ]]; then
        if [[ "$REPLY" =~ ^[1]$ ]]; then
            echo "You have selected to copy a file to a remote system"
            echo
            read -p "Please input the path to file:  " filePath
            read -p "Please input the destination path:  " destinationPath
            echo
            scp -P $portInput $filePath $usernameInput@$ipInput:$destinationPath
            echo
            sleep $DELAY
        fi
        if [[ "$REPLY" =~ ^[2]$ ]]; then
            echo "You have selected to copy a file from a remote system"
            echo
            read -p "Please input the path to file:  " filePath
            read -p "Please input the destination path:  " destinationPath
            echo
            scp -P $portInput $usernameInput@$ipInput:$filePath $destinationPath
            echo
            sleep $DELAY
        fi
        if [[ "$REPLY" =~ ^[3]$ ]]; then
            clear
            ./$(basename $0) && exit
        fi
        if [[ "$REPLY" =~ ^[4]$ ]]; then
            clear
            ssh $usernameInput@$ipInput -p $portInput
        fi
        else
            echo "Input Error. Please try again.."
            sleep $DELAY
    fi
done
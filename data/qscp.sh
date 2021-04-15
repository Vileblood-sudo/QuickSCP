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
DELAY=3
echo
echo "Ensure SSH is open on connecting server"
echo
read -p "Please input the IP Address:  " ipInput
read -p "Please input the username:  " usernameInput
read -p "Please input the port:  " portInput


while [[ "$REPLY" != 0 ]]; do
	clear
	cat <<EOF
	Please select from the following options:

    1.) Copy a file to a remote system
    2.) Copy a file from a remote system
    3.) Change server data
	
EOF
  
	read -p "Enter your selection [1-3]> "
  
	if [[ "$REPLY" =~ ^[1-3]$ ]]; then
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
        if [[ "$REPLY" =~ ^[3]$ ]]; then
            clear
            ./$(basename $0) && exit
        fi
        else
            echo "Input Error. Please try again.."
            sleep $DELAY
    fi
done
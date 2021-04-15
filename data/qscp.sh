#!/bin/bash
#
#######################
# ./qscp.sh -h for help
#######################
displayHelp () {
    echo
    echo "QuickSCP was written to perform Secure Copy file transfer via SSH protocol."
    echo "Steven Thompson is not responsible if QuickSCP is used for malicious purposes."
    echo
    echo "Filepath syntax examples:"
    echo "Windows - C:/file.txt"
    echo "Linux - /home/user/file.txt"
    echo
    echo "Ensure SSH is open on the connecting system"
}
while getopts ":h" option; do
    case $option in
    h)
    clear
    displayHelp
    exit;;
   esac
done
#######################
# Main script start
#######################
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
echo "Please note: File transfer logs are saved to home directory"
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
displayTarget () {
    echo "Target IP - $ipInput"
    echo "Target Port - $portInput"
}

id idVar
while [[ "$REPLY" != 0 ]]; do
    clear
	cat <<EOF

	Please select from the following options:

    1.) Copy a file to a remote system
    2.) Copy a file from a remote system
    3.) Change server data
    4.) Remote into server
    5.) Execute remote command
    6.) Show help 
	
EOF
  
	read -p "Enter your selection [1-6]> "


    if [[ "$REPLY" =~ ^[1-6]$ ]]; then
        if [[ "$REPLY" =~ ^[1]$ ]]; then
            clear
            displayTarget
            echo
            echo "You have selected to copy a file to a remote system"
            echo
            read -p "Please input the path to file:  " filePath
            read -p "Please input the destination path:  " destinationPath
            echo
            scp -P $portInput $filePath $usernameInput@$ipInput:$destinationPath >> /home/$idVar/QSCP.log
            echo
            sleep $DELAY
        fi
        if [[ "$REPLY" =~ ^[2]$ ]]; then
            clear
            displayTarget
            echo
            echo "You have selected to copy a file from a remote system"
            echo
            read -p "Please input the path to file:" filePath
            read -p "Please input the destination path:  " destinationPath
            echo
            scp -P $portInput $usernameInput@$ipInput:$filePath $destinationPath >> /home/$idVar/QSCP.log
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
        if [[ "$REPLY" =~ ^[5]$ ]]; then
            clear
            displayTarget
            echo
            read -p "Please enter the command you wish to execute:  " cInput
            ssh $usernameInput@$ipInput -p $portInput $cInput >> /home/$idVar/QSCPexecute.log
            sleep $DELAY
        fi
        if [[ "$REPLY" =~ ^[6]$ ]]; then
            clear
            displayHelp
            echo
            read -rsp $'Press any key to continue...\n' -n1 key
        fi
        else
            echo "Input Error. Please try again.."
            sleep $DELAY
    fi
done
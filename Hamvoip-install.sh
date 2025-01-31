#!/bin/bash

# Script by KD2YKY & KF0LPT

# Elevate to root
sudo -s <<EOF
EOF

# Change to /etc/asterisk/local directory
mkdir /etc/asterisk/local
cd /etc/asterisk/local

# Creates check_connect.sh file.
echo "creating check_connect.sh file"
sleep 2
echo '#!/bin/bash

#Check Connection to a designated AllStarLink node and reconnect if disconnected

#Set your AllStarLink node number and the target node number you want to check to the connection

#Change xxxx to the node number on this radio

#Change xxxxx to the node number you want to perm connect to

MY_NODE=xxxx

TARGET_NODE=xxxxx

#Check if the target node is connected

if ! /usr/sbin/asterisk -rx "rpt lstats $MY_NODE" | grep -q "$TARGET_NODE"; then

echo "Node $MY_NODE is not connected to node $TARGET_NODE. Reconnecting..."

sudo /usr/sbin/asterisk -rx "rpt fun $MY_NODE *3$TARGET_NODE"

else

echo "Node $MY_NODE is already connected to node $TARGET_NODE."

fi' > /etc/asterisk/local/check_connect.sh

echo "check_connect.sh file has been created. Config File /etc/asterisk/local  DO NOT FOR GET TO CONFIGURE IT AT THE END OF INSTALL."

sleep 2

echo "Making check_connect.sh executable."
# Makes check_connect.sh executable 

chmod +x /etc/asterisk/local/check_connect.sh

# Create Crontab

{
    echo "Installation and configuration complete. Please edit the check_connection.sh file as per your needs."
    read -r -p "Would you like create the crontab file now? (Y/n): " EDIT_CONFIG
    EDIT_CONFIG=${EDIT_CONFIG:-y}
    if [[ "$EDIT_CONFIG" =~ ^[Yy]$ ]]; then
         echo "Setting up cron job..."
CRON_COMMENT="# check_connect.sh crontab entry"
CRON_JOB="*/10 * * * * /etc/asterisk/local/check_connect.sh"
(sudo crontab -l 2>/dev/null; echo "$CRON_COMMENT"; echo "$CRON_JOB") | sudo crontab -
echo "Current crontab for root:"
sudo crontab -l
echo "All installations are complete. Make sure to edit the check_connect.sh file located."
echo "in /etc/asterisk/local and add in your node number and the target node."
cd /etc/asterisk/local
    else
        echo "You can edit the crontab file later using crontab -e. DO NOT FORGET to configure the check_connect.sh file located in /etc/asterisk/local."
    fi
}


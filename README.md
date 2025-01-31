To Install check connect

need to be root to run the commands below use the following to gain root access

sudo -s

We now need to change directorys so enter:
cd

To get the script file downloaded onto your node just use this command:

wget https://raw.githubusercontent.com/joshnbrown23/testconnection/refs/heads/main/check_connect.sh

We need to make the file executable now
chmod +x check_connect.sh

Now run the install
./check_connect.sh

Once the file has been downloaded we need to make a few customizations. For example we need to edit in your node number and the target node number you want to stay connected to. You can so that by using the following command:

sudo nano check_connection.sh

Remove the X's on the line that starts with "MY_NODE" and replace them with your node number. Then remove the X's on the line beginning with TARGET_NODE and replace them with the node number you wish to stay connected to.
Then save the file (if you are using nano then hit CTL + X and then Y to save and enter to exit).


If  you Skipped the cronjob entry we will need to create that.
I like to set mine for every 10 minuets and this can be achieved with this crontab entry. 
To open this crontab editor go to the command line and execute this command:

sudo crontab -e

Once in the crontab you can enter this line and then next available space in the file:

*/10 * * * * /etc/asterisk/local/check_connection.sh

Once it is entered you can hit CTL + X then Y to save and enter exit.

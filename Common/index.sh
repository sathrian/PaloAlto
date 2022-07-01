#!/bin/bash
#
# This script generates a static web page which can be used to
# verify server host information when testing labs using a browser.
#
# Run the script manually to generate an index.html file that is placed in
# /var/www/html.
# 
# The script has been placed in the autostart folder of this host and is run
# automatically each time lab-user logs in. This action updates the index.html
# file with any relevant details for the host.

echo "Generating web page..."
HOSTNAME=$(hostname)
TITLE="System Information for $HOSTNAME"
CURRENT_TIME=$(date)
# TIME_STAMP="Updated on $CURRENT_TIME"
# UPTIME=$(uptime -p)
IPADDR=$(hostname -I)
# SRCADDR=`tail -1 /var/log/apache2/access.log | awk '{print $1}'`
OS=$(uname)
GW=$(cat /etc/network/interfaces | grep gateway | awk '{print $2}')
SPACE=$(df -h --total | grep total | awk '{print $4}')
clear
rm index.html
touch index.html

echo "<title>" > index.html
echo $HOSTNAME >> index.html
echo "</title>" >> index.html
    
echo "<html>" >> index.html
     echo '<body style="background-color:lightgrey;">' >> index.html
     echo "<head>" >> index.html
         echo "<title>" >> index.html
             echo "$TITLE" >> index.html
         echo "</title>" >> index.html

            echo "<body>" >> index.html
echo "<p>" >> index.html
echo '<a href="https://www.paloaltonetworks.com">' >> index.html
echo '<img src="PANW.png" width="500" height="100">' >> index.html
echo "</a>" >> index.html
echo "</p>" >> index.html

                echo "<h1>" >> index.html
                echo "Server Information:" >> index.html
                echo "</h1>" >> index.html

        echo '<b>Server operating system: </b>'$OS >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html

        echo '<b>Server drive space available: </b>'$SPACE >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html


            echo '<b>Server IP address: </b>'$IPADDR  >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html

        echo '<b>Server Default Gateway: </b>' $GW>> index.html

#                echo "Server has been "$UPTIME >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html

#            echo "Your source IP address is " $SRCADDR >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html
            echo "</br>" >> index.html

echo "Page generated on " $CURRENT_TIME >> index.html

   echo "</body>" >> index.html
   echo "</html>" >> index.html
   echo "</head>" >> index.html

sudo cp index.html /var/www/html/
echo "Process complete. Connect to http://localhost to verify."
echo "You can also connect to http://"$IPADDR
echo ""
echo ""



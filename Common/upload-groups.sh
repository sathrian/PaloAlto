#!/bin/bash
#
# Script to populate firewall-a with userid entries
#
# Version 2-20-2020a
# Bill Claunch
# Palo Alto Networks
# For official use only
#
clear
echo ""
echo ""
echo "Sending userID to firewall-a"
echo ""
echo ""
#
######################################################################################################
# Get Key from Firewall-A and write to FirewallA.keyfile.txt
######################################################################################################
curl -k -X GET "https://192.168.1.254/api/?type=keygen&user=admin&password=Pal0Alt0!" >FirewallA.keyfile.txt
                # clean up extraneous characters in API response to leave only key
                # Remove > characters 
                sed --in-place "s/>/ /g" FirewallA.keyfile.txt
                # Remove < characters
                sed --in-place "s/</ /g" FirewallA.keyfile.txt
                # Remove single quotes
                sed --in-place "s/'/ /g" FirewallA.keyfile.txt
                # Remove extraneous text before key
                sed --in-place 's/ response status =  success   result  key //g' FirewallA.keyfile.txt
                # Remove slashes
                sed --in-place 's/\///g' FirewallA.keyfile.txt
                # Remove extraneous text after key
                sed --in-place 's/ key  result  response //g' FirewallA.keyfile.txt
                clear
                echo "Your key is below:"
                echo ""
                cat FirewallA.keyfile.txt
                echo ""
                echo ""
                echo "The key is also stored in the current directory as " FirewallA.keyfile.txt
                echo ""
                echo -n "Press enter to proceed"
        clear
######################################################################################################
# Read FirewallA.keyfile.txt into variable.
######################################################################################################
# read API key for FirewallA from FirewallA.keyfile.txt into variable
                tempkeyA=`cat FirewallA.keyfile.txt`
######################################################################################################
echo ""
# "https://192.168.1.254/api/?type=user-id" > /home/paloalto42/empty.txt
sudo curl -k -F key=$tempkeyA --form file=@/home/lab-user/Desktop/Lab-Files/Common/groups.xml "https://192.168.1.254/api/?type=user-id" > /home/lab-user/Desktop/Lab-Files/empty.txt
echo ""
echo "Process Complete."
echo ""
echo "Use the command show user ip-user-mapping all on the firewall to see"
echo "list of users."
echo ""
echo "Use the command clear user-cache all on the firewall to clear"
echo "the list of users."
echo ""
echo ""
rm /home/lab-user/Desktop/Lab-Files/empty*
rm /home/lab-user/Desktop/Lab-Files/FirewallA.keyfile.txt
echo "Done."
echo ""

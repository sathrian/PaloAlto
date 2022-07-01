#!/bin/bash
# Script to clear logs from firewalls and Panorama
# 
# Bill Claunch
# Feb 7, 2020
# 
#
# Need section to get API key and turn to variables for firewall-a, firewall-b and Panorama
#

######################################################################################################
# Get Key from Firewall-A and write to Akeyfile.txt
######################################################################################################
clear
echo "Get API key for Firewall-A"
echo ""
curl -k -X GET "https://192.168.1.254/api/?type=keygen&user=admin&password=Pal0Alt0!" >Akeyfile.txt
                # clean up extraneous characters in API response to leave only key
                # Remove > characters 
                sed --in-place "s/>/ /g" Akeyfile.txt
                # Remove < characters
                sed --in-place "s/</ /g" Akeyfile.txt
                # Remove single quotes
                sed --in-place "s/'/ /g" Akeyfile.txt
                # Remove extraneous text before key
                sed --in-place 's/ response status =  success   result  key //g' Akeyfile.txt
                # Remove slashes
                sed --in-place 's/\///g' Akeyfile.txt
                # Remove extraneous text after key
                sed --in-place 's/ key  result  response //g' Akeyfile.txt
#                echo "Your key is below:"
#                echo ""
#                cat Akeyfile.txt
#                echo ""
#                echo ""
#                echo "The key is also stored in the current directory as " Akeyfile.txt
#                echo ""
#                echo -n "Press enter to proceed"
echo "Done."
######################################################################################################
# Read Akeyfile.txt into variable.
######################################################################################################
# read API key for FirewallA from Akeyfile.txt into variable
                tempkeyA=`cat Akeyfile.txt`
######################################################################################################

echo ""

# Clear Threat Log Firewall-A
echo "Clearing Threat Logs...on Firewall-A"
curl -k "https://192.168.1.254/api/?type=op&cmd=<clear><log><threat></threat></log></clear>&key=$tempkeyA"
echo "Complete."

# Clear Traffic Log Firewall-A
echo "Clearing Traffic Logs...on Firewall-A"
curl -k "https://192.168.1.254/api/?type=op&cmd=<clear><log><traffic></traffic></log></clear>&key=$tempkeyA"
echo "Complete."

######################################################################################################
# Get Key from Firewall-B and write to Bkeyfile.txt
######################################################################################################
echo "Get API key for Firewall-B"
echo ""
curl -k -X GET "https://192.168.1.253/api/?type=keygen&user=admin&password=Pal0Alt0!" >Bkeyfile.txt
                # clean up extraneous characters in API response to leave only key
                # Remove > characters 
                sed --in-place "s/>/ /g" Bkeyfile.txt
                # Remove < characters
                sed --in-place "s/</ /g" Bkeyfile.txt
                # Remove single quotes
                sed --in-place "s/'/ /g" Bkeyfile.txt
                # Remove extraneous text before key
                sed --in-place 's/ response status =  success   result  key //g' Bkeyfile.txt
                # Remove slashes
                sed --in-place 's/\///g' Bkeyfile.txt
                # Remove extraneous text after key
                sed --in-place 's/ key  result  response //g' Bkeyfile.txt
#                echo "Your key is below:"
#                echo ""
#                cat Bkeyfile.txt
#                echo ""
#                echo ""
#                echo "The key is also stored in the current directory as " Bkeyfile.txt
#                echo ""
#                echo -n "Press enter to proceed"
######################################################################################################
# Read Bkeyfile.txt into variable.
######################################################################################################
# read API key for FirewallB from Bkeyfile.txt into variable
                tempkeyB=`cat Bkeyfile.txt`
######################################################################################################



# Clear Threat Log Firewall-B
echo "Clearing Threat Logs...on Firewall-B"
curl -k "https://192.168.1.253/api/?type=op&cmd=<clear><log><threat></threat></log></clear>&key=$tempkeyB"
echo "Complete."

# Clear Traffic Log Firewall-B
echo "Clearing Traffic Logs...on Firewall-B"
curl -k "https://192.168.1.253/api/?type=op&cmd=<clear><log><traffic></traffic></log></clear>&key=$tempkeyB"
echo "Complete."

######################################################################################################
# Get Key from Panorama and write to PANOkeyfile.txt
######################################################################################################
echo "Get API key for Panorama"
echo ""
curl -k -X GET "https://192.168.1.252/api/?type=keygen&user=admin&password=Pal0Alt0!" >PANOkeyfile.txt
                # clean up extraneous characters in API response to leave only key
                # Remove > characters 
                sed --in-place "s/>/ /g" PANOkeyfile.txt
                # Remove < characters
                sed --in-place "s/</ /g" PANOkeyfile.txt
                # Remove single quotes
                sed --in-place "s/'/ /g" PANOkeyfile.txt
                # Remove extraneous text before key
                sed --in-place 's/ response status =  success   result  key //g' PANOkeyfile.txt
                # Remove slashes
                sed --in-place 's/\///g' PANOkeyfile.txt
                # Remove extraneous text after key
                sed --in-place 's/ key  result  response //g' PANOkeyfile.txt

#                echo "Your key is below:"
#                echo ""
#                cat PANOkeyfile.txt
#                echo ""
#                echo ""
#                echo "The key is also stored in the current directory as " PANOkeyfile.txt
#                echo ""
#                echo -n "Press enter to proceed"
######################################################################################################
# Read PANOkeyfile.txt into variable.
######################################################################################################
# read API key for PanoPama from PANOkeyfile.txt into variable
                tempkeyPANO=`cat PANOkeyfile.txt`
######################################################################################################

# Clear Threat Log Panorama
echo "Clearing Threat Logs...on Panorama"
curl -k "https://192.168.1.252/api/?type=op&cmd=<clear><log><threat></threat></log></clear>&key=$tempkeyPANO"
echo "Complete."

# Clear Traffic Log Panorama
echo "Clearing Traffic Logs...on Panorama"
curl -k "https://192.168.1.252/api/?type=op&cmd=<clear><log><traffic></traffic></log></clear>&key=$tempkeyPANO"
echo "Complete."


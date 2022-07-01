# Need to run this under bash explicitly - bash <scriptname.sh>

#!/bin/bash
#####################
# BEGIN COLORS SECTION
#
# Set colors to use within script itself for printed output
##
RED='\033[1;31m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
NC='\033[0m'
#
# END COLORS SECTION
#####################
#
#####################
# BEGIN SECTION FOR LAB VARIABLES
#
# Set Lab number variable
#
# Change these variables to reflect the Lab Number and Lab Title
#
LABNUMBER=19
LABTITLE="Capstone"
#
#
# END SECTION FOR LAB VARIABLES
#####################
#
#
# BEGIN EXPLANATION SECTION
#####################

clear
echo "    ##############################################" | pv -qL 120
echo "    ##          Capstone Lab Scoring            ##" | pv -qL 120
echo "    ##############################################" | pv -qL 120
echo ""
echo "    This script will retrieve the running configuration from your firewall and determine whether" | pv -qL 120
echo "    you have met the requirements of the Capstone lab." | pv -qL 120
echo ""
echo "    The script expects exact matches for configuration elements, including capitalization, " | pv -qL 120
echo "    spelling and separators." | pv -qL 120
echo ""
echo "    This script is only a guide to give you a general idea of how closely you have met the requirements" | pv -qL 120
echo "    listed for the Capstone lab." | pv -qL 120
echo ""
echo -n "    Press ENTER to continue or CTRL+C to quit." | pv -qL 120
                read anykey
clear

echo "    These are the items that the grading script examines:" | pv -qL 120
echo ""
echo "    >> Correct interface addresses and settings" | pv -qL 120
echo "    >> Correct default route for firewall" | pv -qL 120
echo "    >> Correct interface management profile setting" | pv -qL 120
echo "    >> Correct Security Policy Rule Names and Settings" | pv -qL 120
echo "       >> Users_to_Internet" | pv -qL 120
echo "       >> Users_to_Extranet" | pv -qL 120
echo "       >> Extranet_to_Internet" | pv -qL 120
echo "       >> Block_Bad_URLs" | pv -qL 120
echo "    >> Correct NAT Policy Rule Names and Settings" | pv -qL 120
echo "    >> Corporate Security Profile Group that contains correct Security Profiles" | pv -qL 120
echo ""
echo ""
echo "    Make sure you have committed your changes to the firewall before you" | pv -qL 120
echo "    continue with this script" | pv -qL 120
echo ""
echo -n "    Press ENTER to continue or CTRL+C to quit." | pv -qL 120
                read anykey

#####################
# BEGIN SECTION TO GET CONFIG FILE
#
# This section uses curl to pull configuration file from firewall using API
#
# Get Key from Firewall-A and write to Akeyfile.txt
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
echo "Done."
#
# Read Akeyfile.txt into variable.
#
# read API key for FirewallA from Akeyfile.txt into variable
                tempkeyA=`cat Akeyfile.txt`
######################################################################################################

echo ""
#
#
# Remove configuration file from current directory if it exists
rm running-config.xml
FILENAME=LAB
# Pull current running configuration file from firewall
 #
clear
echo "Retrieving configuration file from your firewall..."
echo ""
sleep 1
#
curl -kG "https://192.168.1.254/api/?type=export&category=configuration&key=$tempkeyA" > running-config.xml
#
# Create myscores.txt file
# Use touch only in first lab grade script
# all others will append
# touch myscores.txt
#
# echo "" >> myscores.txt
# echo "Lab "$LABNUMBER >> myscores.txt
#echo $LABTITLE >> myscores.txt
#echo ------------------------ >> myscores.txt
#echo "" >> myscores.txt
#
#echo ""
#echo "Complete"
#echo ""

#
# END SECTION TO GET CONFIG FILE
#####################
#
#####################
# BEGIN SECTION TO STRIP XML GIBBERISH FROM CONFIG FILE
                # clean up extraneous characters in Config File and to separate elements with +
                # Remove > characters 
                sed --in-place "s/>/+/g" running-config.xml
                # Remove < characters
                sed --in-place "s/</+/g" running-config.xml
                # Remove single quotes
                sed --in-place "s/\'/+/g" running-config.xml
                # Remove slashes
                sed --in-place "s/\/+/g" running-config.xml
                sed --in-place "s/\//+/g" running-config.xml
                # Replace double quotes with ^
                sed --in-place "s/\"/^/g" running-config.xml

# cat running-config.xml

# Copy running-config.xml to LabNumber_LabTitle_Config.xml format
cp running-config.xml Lab_"$LABNUMBER"_"$LABTITLE"_Config.xml

# BEGIN SECTION TO READ CONFIGURATION FILE INTO VARIABLE
#
# Read in LabNumber_LabTitle_Config.xml file as ConfigFile variable
ConfigFile=`cat Lab_"$LABNUMBER"_"$LABTITLE"_Config.xml`
#
#END SECTION TO READ CONFIGURATION FILE INTO VARIABLE
#####################
#
#####################
#
# START RESULTS SECTION
#
# The script will look for these values within the ConfigFile
#
# Enter values to look for within ConfigFile
# Easiest way is to open running-config.xml in text editor
# and copying section to look for.
#
# Avoid using quoted values in variable for the time being
# such as a field with spaces.
#
# This section defines variables for search and descriptions.

# ----------------------------------------------------------------------------
# Start Network Section Variables
# ----------------------------------------------------------------------------

        #####################
        # Result aa
        # Description - Update this section to include what the variable actually is:
        Descriptionaa="Interface ethernet1/1 correct IP address"
        resultaa="+entry name=^ethernet1+1^++layer3++ndp-proxy++enabled+no++enabled+++ndp-proxy++ip++entry name=^203.0.113.20+24^++"

        #####################
        # Result bb
        # Description - Update this section to include what the variable actually is:
        Descriptionbb="Interface ethernet1/2 correct IP address"
        resultbb="+entry name=^ethernet1+2^++layer3++ndp-proxy++enabled+no++enabled+++ndp-proxy++ip++entry name=^192.168.1.1+24^++"

        #####################
        # Result cc
        # Description - Update this section to include what the variable actually is:
        Descriptioncc="Interface ethernet1/3 correct IP address"
        resultcc="+entry name=^ethernet1+3^++layer3++ndp-proxy++enabled+no++enabled+++ndp-proxy++ip++entry name=^192.168.50.1+24^++"

        #####################
        # Result dd
        # Description - Update this section to include what the variable actually is:
        Descriptiondd="Allow_ping interface management profile"
        resultdd="Allow_ping+"

        #####################
        # Result ee
        # Description - Update this section to include what the variable actually is:
        Descriptionee="Default route for firewall set correctly"
        resultee="+nexthop++ip-address+203.0.113.1++"

# ----------------------------------------------------------------------------
# Start Security Rules Section Variables
# ----------------------------------------------------------------------------

        #####################
        # Result 1
        # Description - Update this section to include what the variable actually is:
        Description1="Users_to_Internet Security policy rule"
        result1="Users_to_Internet"
        #####################
        # Result 2
        # Description - Update this section to include what the variable actually is:
        Description2="Users_to_Extranet Security policy rule"
        result2="Users_to_Extranet"
        #####################
        # Result 3
        # Description - Update this section to include what the variable actually is:
        Description3="Extranet_to_Internet Security policy rule"
        result3="Extranet_to_Internet"
        #####################
        # Result 4
        # Description - Update this section to include what the variable actually is:
        Description4="Block_Bad_URLs Security policy rule"
        result4="Block_Bad_URLs"

# ----------------------------------------------------------------------------
# End Security Rules Section Variables
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Start NAT Rules Section Variables
# ----------------------------------------------------------------------------

        #####################
        # Result a1
        # Description - Update this section to include what the variable actually is:
        Descriptiona1="Users_to_Internet NAT policy rule"
        resulta1="nat rules Users_to_Internet source-translation dynamic-ip-and-port interface-address ip 203.0.113.20/24"
        #####################

# ----------------------------------------------------------------------------
# End NAT Rules Section Variables
# ----------------------------------------------------------------------------


# END RESULTS SECTION
#####################
#
#####################
# BEGIN SCRIPT
#
#####################
#
# Print Lab Number and Title
clear
echo -e "Lab Number ${WHITE}$LABNUMBER${NC}"
echo -e "Lab Title  ${WHITE}$LABTITLE${NC}"
echo ""
# Print output
sleep 1
echo ""
# ----------------------------------------------------------------------------
# Start Compare ConfigFile to result
# ----------------------------------------------------------------------------

echo "Comparing your file to expected results..."
echo ""
echo "Network Settings:"

# ----------------------------------------------------------------------------
# Start Networking Section
# ----------------------------------------------------------------------------
if [[ $ConfigFile == *$resultaa* ]]; then
# echo out PASS in green if config does contain result1a
sleep 1
# Alignment guide
 	echo "-----------------------------------------------------"
    echo $Descriptionaa
	echo -e  "     ${GREEN}PASS${NC}"
else
# echo out FAIL in red if config does not contain result1a
 	echo "-----------------------------------------------------"
    echo $Descriptionaa
	echo -e "     ${RED}FAIL${NC}"
    echo ""
    echo -e "     Double-check the configuration settings for this item and run the script again."
sleep 1
fi
 	echo "-----------------------------------------------------"

# ----------------------------------------------------------------------------
# End Compare ConfigFile to result
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Start Compare ConfigFile to result
# ----------------------------------------------------------------------------
if [[ $ConfigFile == *$resultbb* ]]; then
# echo out PASS in green if config does contain result1a
sleep 1
# Alignment guide
 	echo "-----------------------------------------------------"
    echo $Descriptionbb
	echo -e  "     ${GREEN}PASS${NC}"
else
# echo out FAIL in red if config does not contain result1a
 	echo "-----------------------------------------------------"
    echo $Descriptionbb
	echo -e "     ${RED}FAIL${NC}"
    echo ""
    echo -e "     Double-check the configuration settings for this item and run the script again."
sleep 1
fi
 	echo "-----------------------------------------------------"

# ----------------------------------------------------------------------------
# End Compare ConfigFile to result
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# Start Compare ConfigFile to result
# ----------------------------------------------------------------------------
if [[ $ConfigFile == *$resultcc* ]]; then
# echo out PASS in green if config does contain result1a
sleep 1
# Alignment guide
 	echo "-----------------------------------------------------"
    echo $Descriptioncc
	echo -e  "     ${GREEN}PASS${NC}"
else
# echo out FAIL in red if config does not contain result1a
 	echo "-----------------------------------------------------"
    echo $Descriptioncc
	echo -e "     ${RED}FAIL${NC}"
    echo ""
    echo -e "     Double-check the configuration settings for this item and run the script again."
sleep 1
fi
 	echo "-----------------------------------------------------"

# ----------------------------------------------------------------------------
# End Compare ConfigFile to result
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Start Compare ConfigFile to result
# ----------------------------------------------------------------------------
if [[ $ConfigFile == *$resultdd* ]]; then
# echo out PASS in green if config does contain result1a
sleep 1
# Alignment guide
 	echo "-----------------------------------------------------"
    echo $Descriptiondd
	echo -e  "     ${GREEN}PASS${NC}"
else
# echo out FAIL in red if config does not contain result1a
 	echo "-----------------------------------------------------"
    echo $Descriptiondd
	echo -e "     ${RED}FAIL${NC}"
    echo ""
    echo -e "     Double-check the configuration settings for this item and run the script again."
sleep 1
fi
 	echo "-----------------------------------------------------"

# ----------------------------------------------------------------------------
# End Compare ConfigFile to result
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Start Compare ConfigFile to result
# ----------------------------------------------------------------------------
if [[ $ConfigFile == *$resultee* ]]; then
# echo out PASS in green if config does contain result1a
sleep 1
# Alignment guide
 	echo "-----------------------------------------------------"
    echo $Descriptionee
	echo -e  "     ${GREEN}PASS${NC}"
else
# echo out FAIL in red if config does not contain result1a
 	echo "-----------------------------------------------------"
    echo $Descriptionee
	echo -e "     ${RED}FAIL${NC}"
    echo ""
    echo -e "     Double-check the configuration settings for this item and run the script again."
sleep 1
fi
 	echo "-----------------------------------------------------"

# ----------------------------------------------------------------------------
# End Compare ConfigFile to result
# ----------------------------------------------------------------------------

echo -n "    Press ENTER to continue or CTRL+C to quit." | pv -qL 120
                read anykey

# ----------------------------------------------------------------------------
# End Networking Section
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Start Security Rules Section
# ----------------------------------------------------------------------------
clear
echo "Security Rules and Settings:"
# ----------------------------------------------------------------------------
# Start Compare ConfigFile to result
# ----------------------------------------------------------------------------
if [[ $ConfigFile == *$result1* ]]; then
# echo out PASS in green if config does contain result1a
sleep 1
# Alignment guide
 	echo "-----------------------------------------------------"
    echo $Description1
	echo -e  "     ${GREEN}PASS${NC}"
else
# echo out FAIL in red if config does not contain result1a
 	echo "-----------------------------------------------------"
    echo $Description1
	echo -e "     ${RED}FAIL${NC}"
    echo ""
    echo -e "     Double-check the configuration settings for this item and run the script again."
sleep 1
fi
 	echo "-----------------------------------------------------"

# ----------------------------------------------------------------------------
# End Compare ConfigFile to result
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# Start Compare ConfigFile to result
# ----------------------------------------------------------------------------
if [[ $ConfigFile == *$result2* ]]; then
# echo out PASS in green if config does contain result1a
sleep 1
# Alignment guide
 	echo "-----------------------------------------------------"
    echo $Description2
	echo -e  "     ${GREEN}PASS${NC}"
else
# echo out FAIL in red if config does not contain result1a
 	echo "-----------------------------------------------------"
    echo $Description2
	echo -e "     ${RED}FAIL${NC}"
    echo ""
    echo -e "     Double-check the configuration settings for this item and run the script again."
sleep 1
fi
 	echo "-----------------------------------------------------"

# ----------------------------------------------------------------------------
# End Compare ConfigFile to result
# ----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# Start Compare ConfigFile to result
# ----------------------------------------------------------------------------
if [[ $ConfigFile == *$result3* ]]; then
# echo out PASS in green if config does contain result1a
sleep 1
# Alignment guide
 	echo "-----------------------------------------------------"
    echo $Description3
	echo -e  "     ${GREEN}PASS${NC}"
else
# echo out FAIL in red if config does not contain result1a
 	echo "-----------------------------------------------------"
    echo $Description3
	echo -e "     ${RED}FAIL${NC}"
    echo ""
    echo -e "     Double-check the configuration settings for this item and run the script again."
sleep 1
fi
 	echo "-----------------------------------------------------"

# ----------------------------------------------------------------------------
# End Compare ConfigFile to result
# ----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# Start Compare ConfigFile to result
# ----------------------------------------------------------------------------
if [[ $ConfigFile == *$result4* ]]; then
# echo out PASS in green if config does contain result1a
sleep 1
# Alignment guide
 	echo "-----------------------------------------------------"
    echo $Description4
	echo -e  "     ${GREEN}PASS${NC}"
else
# echo out FAIL in red if config does not contain result1a
 	echo "-----------------------------------------------------"
    echo $Description4
	echo -e "     ${RED}FAIL${NC}"
    echo ""
    echo -e "     Double-check the configuration settings for this item and run the script again."
sleep 1
fi
 	echo "-----------------------------------------------------"

# ----------------------------------------------------------------------------
# End Compare ConfigFile to result
# ----------------------------------------------------------------------------


echo -n "    Press ENTER to continue or CTRL+C to quit." | pv -qL 120
                read anykey

# ----------------------------------------------------------------------------
# End Security Rules Section
# ----------------------------------------------------------------------------
clear
echo "NAT Policy Rules and Settings:"
# ----------------------------------------------------------------------------
# Start NAT Rules Section
# ----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# Start Compare ConfigFile to result
# ----------------------------------------------------------------------------
if [[ $ConfigFile == *$result1a* ]]; then
# echo out PASS in green if config does contain result1a
sleep 1
# Alignment guide
 	echo "-----------------------------------------------------"
    echo $Description1a
	echo -e  "     ${GREEN}PASS${NC}"
else
# echo out FAIL in red if config does not contain result1a
 	echo "-----------------------------------------------------"
    echo $Description1a
	echo -e "     ${RED}FAIL${NC}"
    echo ""
    echo -e "     Double-check the configuration settings for this item and run the script again."
sleep 1
fi
 	echo "-----------------------------------------------------"

# ----------------------------------------------------------------------------
# End Compare ConfigFile to result
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# END NAT Rules Section
# ----------------------------------------------------------------------------


echo "Complete"
###########
###########
# BEGIN CLEANUP SECTION
#
# Remove running-config.xml and Lab_19_Capstone_Config.xml
rm running-config.xml
rm Lab_19_Capstone_Config.xml
#
# Move LabConfiguration file to MyLabScores directory
# mv *xml MyLabScores/
###########
# To Do
#

# Figure out how to output overall PASS or FAIL for entire lab
# Hide script text to keep people from cheating - set execute permission but not read?
# Consider piping score text to grading file for all labs.


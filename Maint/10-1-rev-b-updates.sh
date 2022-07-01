#!/bin/bash
# set -x
# Script to upload configuration files to Firewall-A for EDU-210
# Bill Claunch
# Palo Alto Networks
# October 2021
clear
echo "This script performs the following tasks:"
echo ""
echo "> Creates a backup directory and copies existing 10.1a configuration files into"
echo "  the backup directory for each course"
echo "> Replaces 10.1 version A configuration files for Firewall-A, Firewall-B and Panorama"
echo "  with version B configuration files for the EDU-210, 214, 220, 330 courses."
echo "> Renames the EDU-330 10.1b configuration files stored on this host to match the"
echo "  new module numbering used in the Rev B Lab Guide."
echo "> Uploads the replacement 10.1b configuration files to FW-A, FW-B and Panorama."
echo "> Removes all existing 10.1a configuration files from Firewall-A, Firewall-B and"
echo "  Panorama."
echo "> Modifies the 214 upload script which students use in class to reference 10.1b files"
echo "  instead of 10.1a files."
echo "> Loads the base configuration file used to start all classes onto FW-A, FW-B and"
echo "  Panorama and then commits the configuration on each device."
echo ""
echo "Do not wander off, this is a quick process but there are several points at which the"
echo "script will prompt you to press ENTER."
echo ""
                echo -n "Press enter to proceed or use CTRL+C to quit"
                read anykey

echo "210 Course Files"
echo ""
echo "Create new backup directory for Version A configs for 210"

mkdir /home/lab-user/Desktop/Lab-Files/EDU-210/Backups-210vA/

echo "Copy all Version A files to backup directory"

cp /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/* /home/lab-user/Desktop/Lab-Files/EDU-210/Backups-210vA/

echo "Rename Version A files to Version B"

mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-Capstone-end.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-Capstone-end.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-Capstone-start.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-Capstone-start.xml
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-02.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-02.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-03.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-03.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-04.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-04.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-05.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-05.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-06.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-06.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-07.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-07.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-08.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-08.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-09.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-09.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-10.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-10.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-11.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-11.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-12.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-12.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-13.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-13.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1a-lab-14.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/edu-210-10.1b-lab-14.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/FW-A-10.1a-BaseConfig.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/FW-A-10.1b-BaseConfig.xml 
mv /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/FW-A-10.1a-Enhanced-v1.xml /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/FW-A-10.1b-Enhanced-v1.xml 

echo "Prepare to replace files on firewall-a"

echo "Get API Key for firewall-A"
curl -k -X GET "https://192.168.1.254/api/?type=keygen&user=admin&password=Pal0Alt0!" >Akeyfile.txt
# Clean up key file
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
                echo "Your key is below:"
                echo ""
                cat Akeyfile.txt
                echo ""
                echo ""
                echo "The key is also stored in the current directory as " Akeyfile.txt
                echo ""
#                echo -n "Press enter to proceed"
#                read anykey
# read API key for FirewallA from Akeyfile.txt into variable
                tempkeyA=`cat Akeyfile.txt`

echo "Remove 10.1a config files from firewall-A"

curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-14.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-13.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-12.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-11.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-10.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-09.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-08.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-07.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-06.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-05.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-04.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-03.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-lab-02.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>FW-A-10.1a-BaseConfig.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>FW-A-10.1a-Enhanced-v1.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-Capstone-end.xml</saved></config></delete>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<delete><config><saved>edu-210-10.1a-Capstone-start.xml</saved></config></delete>"

echo "214 Course Files"

echo "Create new backup directory for Version A configs for 214"

mkdir /home/lab-user/Desktop/Lab-Files/EDU-214/Backups-214vA/

echo "Move all Version A files to backup directory"

mv /home/lab-user/Desktop/Lab-Files/EDU-214/*.xml /home/lab-user/Desktop/Lab-Files/EDU-214/Backups-214vA/

echo "Copy user-id files back to EDU-214 directory"

cp /home/lab-user/Desktop/Lab-Files/EDU-214/Backups-214vA/Ausers.xml /home/lab-user/Desktop/Lab-Files/EDU-214/
cp /home/lab-user/Desktop/Lab-Files/EDU-214/Backups-214vA/groups.xml /home/lab-user/Desktop/Lab-Files/EDU-214/

echo "Unzip edu-214-10.1b-configs.zip to Desktop"

unzip /home/lab-user/Desktop/edu-214-10.1b-configs.zip -d /home/lab-user/Desktop/Lab-Files/EDU-214/


echo "Update the student upload script - 214-Import-Config.sh -  with the correct rev B filenames"

cp /home/lab-user/Desktop/Lab-Files/EDU-214/214-Import-Config.sh /home/lab-user/Desktop/Lab-Files/EDU-214/214-Import-Config.sh.backup
sed -i 's/10.1a/10.1b/g' /home/lab-user/Desktop/Lab-Files/EDU-214/214-Import-Config.sh

echo "330 Course Files"

echo "Create new backup directory for Version A configs for 330"

mkdir /home/lab-user/Desktop/Lab-Files/EDU-330/backup-configs/

echo "Copy all Version A files to backup directory"

cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/*.xml /home/lab-user/Desktop/Lab-Files/EDU-330/backup-configs/

echo "Rename flow logic files from Lab03 to Lab02:"

cp /home/lab-user/Desktop/Lab-Files/EDU-330/edu-330-lab-03-flow-logic-numbered.txt /home/lab-user/Desktop/Lab-Files/EDU-330/backup-configs/
cp /home/lab-user/Desktop/Lab-Files/EDU-330/edu-330-lab-03-flow-logic.txt /home/lab-user/Desktop/Lab-Files/EDU-330/backup-configs/
mv /home/lab-user/Desktop/Lab-Files/EDU-330/edu-330-lab-03-flow-logic-numbered.txt /home/lab-user/Desktop/Lab-Files/EDU-330/edu-330-lab-02-flow-logic-numbered.txt
mv /home/lab-user/Desktop/Lab-Files/EDU-330/edu-330-lab-03-flow-logic.txt /home/lab-user/Desktop/Lab-Files/EDU-330/edu-330-lab-02-flow-logic.txt

echo "Update timestamps in edu-330-lab-02-flow-logic files from 2018 to 2021"

sed -i 's/2018-03-17/2021-09-17/g' /home/lab-user/Desktop/Lab-Files/EDU-330/edu-330-lab-02-flow-logic.txt
sed -i 's/2018-03-17/2021-09-17/g' /home/lab-user/Desktop/Lab-Files/EDU-330/edu-330-lab-02-flow-logic-numbered.txt

echo "Rename Version A files to Version B"

cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-01.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-01.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-02.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-02.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-04.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-04.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-05.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-05.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-06a.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-06a.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-06b.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-06b.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-07.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-07.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-08.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-08.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-09.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-09.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-10.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-10.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-11.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-11.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-BaseConfig-V1.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-BaseConfig-V1.xml

echo "Rename new version B files to match Version B lab guide changes"

cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-01.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-01.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-02.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-1.3.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-04.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-03.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-05.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-04.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-06a.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-05a.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-06b.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-05b.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-07.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-06.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-08.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-07.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-09.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-08.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-10.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-09.xml
cp /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-11.xml /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1b-Start-Lab-10.xml

echo "Remove version a files from firewall-config-files folder"

rm /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-01.xml
rm /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-02.xml
rm /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-04.xml
rm /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-05.xml
rm /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-06a.xml
rm /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-06b.xml
rm /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-07.xml
rm /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-08.xml
rm /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-09.xml
rm /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-10.xml
rm /home/lab-user/Desktop/Lab-Files/EDU-330/firewall-config-files/330-FWA-10.1a-Start-Lab-11.xml


echo "220 Course Files"

echo "Create new backup directory for Version A configs for 220 Firewall-A"

mkdir /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-A/backup-configs/

echo "Copy all firewall-a Version A files to backup directory"

cp /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-A/*.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-A/backup-configs/

echo "Rename firewall-a Version A files to Version B"

mv /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-A/FW-A-10.1a-BaseConfig.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-A/FW-A-10.1b-BaseConfig.xml

echo "Create new backup directory for Version B configs for 220 Firewall-B"

mkdir /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-B/backup-configs/

echo "Copy all firewall-b Version A files to backup directory"

cp /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-B/*.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-B/backup-configs/

echo "Rename firewall-b Version A files to Version B"

mv /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-B/FW-B-10.1a-BaseConfig.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-B/FW-B-10.1b-BaseConfig.xml

echo "Create new backup directory for Version A configs for 220 Panorama"

mkdir /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/backup-configs/

echo "Copy all Panorama Version A files to backup directory"

cp /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/*.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/backup-configs/

echo "Replace broken FW-A-220 Base config with correct one."

cp /home/lab-user/Desktop/Lab-Files/EDU-210/210-Configs/FW-A-10.1b-BaseConfig.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-A/

echo "Rename Version A files to Version B for Firewall-A 220"

# cp /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-A/FW-A-10.1a-BaseConfig.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-A/FW-A-10.1b-BaseConfig.xml

echo "Rename Version A files to Version B for Firewall-B 220"

cp /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-B/FW-B-10.1a-BaseConfig.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-B/FW-B-10.1b-BaseConfig.xml

echo "Rename Version A files to Version B for Panorama 220"

mv /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/220-Panorama-10.1a-Base-V1.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/220-Panorama-10.1b-Base-V1.xml
mv /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1a-Lab-2-Start.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1b-Lab-2-Start.xml
mv /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1a-Lab-3-Start.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1b-Lab-3-Start.xml
mv /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1a-Lab-4-Start.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1b-Lab-4-Start.xml
mv /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1a-Lab-5-Start.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1b-Lab-5-Start.xml
mv /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1a-Lab-6-Start.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1b-Lab-6-Start.xml
mv /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1a-Lab-7-Start.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1b-Lab-7-Start.xml
mv /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1a-Lab-8-Start.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1b-Lab-8-Start.xml
mv /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1a-Lab-9-Start.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/Panorama/EDU-220-10.1b-Lab-9-Start.xml

echo "Get API Keys for Panorama"

echo "Get API Key for Panorama"
curl -k -X GET "https://192.168.1.252/api/?type=keygen&user=admin&password=Pal0Alt0!" >PANOkeyfile.txt
# Clean up key file
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
                echo "Your key is below:"
                echo ""
                cat PANOkeyfile.txt
                echo ""
                echo ""
                echo "The key is also stored in the current directory as " PANOkeyfile.txt
                echo ""
#                echo -n "Press enter to proceed"
#                read anykey
# read API key for Panorama from PANOkeyfile.txt into variable
                tempkeyPANO=`cat PANOkeyfile.txt`


echo "Remove 10.1a config files from Panorama"

curl -k -F key=$tempkeyPANO "https://192.168.1.252/api/?type=op&cmd=<delete><config><saved>220-Panorama-10.1a-Base-V1.xml</saved></config></delete>"
curl -k -F key=$tempkeyPANO "https://192.168.1.252/api/?type=op&cmd=<delete><config><saved>EDU-220-10.1a-Lab-2-Start.xml</saved></config></delete>"
curl -k -F key=$tempkeyPANO "https://192.168.1.252/api/?type=op&cmd=<delete><config><saved>EDU-220-10.1a-Lab-3-Start.xml</saved></config></delete>"
curl -k -F key=$tempkeyPANO "https://192.168.1.252/api/?type=op&cmd=<delete><config><saved>EDU-220-10.1a-Lab-4-Start.xml</saved></config></delete>"
curl -k -F key=$tempkeyPANO "https://192.168.1.252/api/?type=op&cmd=<delete><config><saved>EDU-220-10.1a-Lab-5-Start.xml</saved></config></delete>"
curl -k -F key=$tempkeyPANO "https://192.168.1.252/api/?type=op&cmd=<delete><config><saved>EDU-220-10.1a-Lab-6-Start.xml</saved></config></delete>"
curl -k -F key=$tempkeyPANO "https://192.168.1.252/api/?type=op&cmd=<delete><config><saved>EDU-220-10.1a-Lab-7-Start.xml</saved></config></delete>"
curl -k -F key=$tempkeyPANO "https://192.168.1.252/api/?type=op&cmd=<delete><config><saved>EDU-220-10.1a-Lab-8-Start.xml</saved></config></delete>"
curl -k -F key=$tempkeyPANO "https://192.168.1.252/api/?type=op&cmd=<delete><config><saved>EDU-220-10.1a-Lab-9-Start.xml</saved></config></delete>"

echo "Call upload script to upload new 210 rev B files to FW-A"

/home/lab-user/Desktop/Lab-Files/Maintenance/Upload_Scripts/210/configuploads-210.sh

echo "Call upload script to upload new 220 files to firewall-A"

/home/lab-user/Desktop/Lab-Files/Maintenance/Upload_Scripts/220/FW-A-configuploads-220.sh

echo "Call upload script to upload new 220 files to Panorama"

/home/lab-user/Desktop/Lab-Files/Maintenance/Upload_Scripts/220/Panorama-configuploads-220.sh

echo "Rename FW-B 220 Base config to version B"

mv /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-B/FW-B-10.1a-BaseConfig-V1.xml /home/lab-user/Desktop/Lab-Files/EDU-220/220-Configs/FW-B/FW-B-10.1b-BaseConfig-V1.xml

echo "Call upload script to upload new 220 files to firewall-B"

/home/lab-user/Desktop/Lab-Files/Maintenance/Upload_Scripts/220/FW-B-configuploads-220.sh

echo "Load FW-A-10.1b-BaseConfig.xml config and commit to Firewall-A"

curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=op&cmd=<load><config><from>FW-A-10.1b-BaseConfig.xml</from></config></load>"
curl -k -F key=$tempkeyA "https://192.168.1.254/api/?type=commit&cmd=<commit></commit>"

echo "Load FW-B-10.1b-BaseConfig.xml config and commit to Firewall-B"

curl -k -F key=$tempkeyA "https://192.168.1.253/api/?type=op&cmd=<load><config><from>FW-B-10.1b-BaseConfig-V1.xml</from></config></load>"
curl -k -F key=$tempkeyA "https://192.168.1.253/api/?type=commit&cmd=<commit></commit>"

echo "Load FW-A-10.1b-BaseConfig.xml config and commit to Panorama"

curl -k -F key=$tempkeyA "https://192.168.1.252/api/?type=op&cmd=<load><config><from>220-Panorama-10.1b-Base-V1.xml</from></config></load>"
curl -k -F key=$tempkeyA "https://192.168.1.252/api/?type=commit&cmd=<commit></commit>"

clear
echo "Process complete."
echo ""
echo "This script is complete."
echo ""
echo "Verify that FW-A, FW-B and Panorama have the appropriate starting configs loaded"
echo "and that the commit process is complete."
echo ""
echo "Afterwards, shut down each device and take new starting snapshots."
echo ""
echo "Move this script from the Desktop to the /home/lab-user/Desktop/Lab-Files/Maintenance"
echo "folder. Then shut this host down and take a new starting snapshot."
echo ""

# 1/15/2020
# Script for mounting NFS share from 192.168.50.150
#
# This is not in the fstab file because access to the server is dependent on
# firewall configuration.
#
# Run this script to mount the /home/paloalto42/ shared folder to
# /mnt/extranet1 on this host. The firewall must allow traffic from User zone (192.168.1.0) to
# Extranet zone (192.168.50.0.
clear
echo "Mounting share from extranet1.lab.local"
echo
echo
sudo mount -o soft,intr,rsize=8192,wsize=8192 192.168.50.150:/home/paloalto42 /mnt/extranet1
echo
df -h
echo
echo "Process complete."

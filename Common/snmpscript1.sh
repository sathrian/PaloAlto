#!/bin/bash
#
# May 4, 2020
# Bill Claunch
# Palo Alto Networks
#
# Script to illustrate SNMP information available from firewall.
#
clear
echo "Enable SNMP access to management interface on firewall-a before running this script."
echo "Make sure community string is public."
echo ""
echo "Get Product Name:"
echo "snmpget -v2c -c public 192.168.1.254 iso.3.6.1.2.1.1.1.0"
snmpget -v2c -c public 192.168.1.254 iso.3.6.1.2.1.1.1.0
echo ""
echo "Get Device Location:"
echo "snmpget -v2c -c public 192.168.1.254 iso.3.6.1.2.1.1.6.0" 
snmpget -v2c -c public 192.168.1.254 iso.3.6.1.2.1.1.6.0
echo ""
echo "Get Device Contact:"
echo "snmpget -v2c -c public 192.168.1.254 iso.3.6.1.2.1.1.4.0"
snmpget -v2c -c public 192.168.1.254 iso.3.6.1.2.1.1.4.0
echo ""
echo "Get Hostname:"
echo "snmpget -v2c -c public 192.168.1.254 iso.3.6.1.2.1.1.5.0"
snmpget -v2c -c public 192.168.1.254 iso.3.6.1.2.1.1.5.0

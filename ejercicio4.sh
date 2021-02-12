#!/bin/bash

if [[ "$#" -ne 3 ]]
then
	echo "usage: $0 <domain name> <community> <SNMP version>"
else
	ipAddr=$(host $1 | awk '{print $4}')
	mask=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.4.20.1.3.$ipAddr | awk '{print $4}')
	echo "Mask: $mask"
fi

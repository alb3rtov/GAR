#!/bin/bash

if [[ "$#" -ne 3  ]]
then
	echo "usage: $0 <domain name> <community> <SNMP version>"
else
	min1=$(snmpget $3 -c $2 $1 .1.3.6.1.4.1.2021.10.1.3.1)
	min5=$(snmpget $3 -c $2 $1  .1.3.6.1.4.1.2021.10.1.3.2)
	min15=$(snmpget $3 -c $2 $1  .1.3.6.1.4.1.2021.10.1.3.3)
	
	echo "Load 1 minute: $(echo $min1 | awk '{print $4}')"
	echo "Load 5 minutes: $(echo $min5 | awk '{print $4}')"
	echo "Load 15 minutes: $(echo $min15 | awk '{print $4}')"
fi


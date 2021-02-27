#!/bin/bash

if [[ "$#" -ne 2 ]]
then
	echo "usage: $0 <domain name> <community>"
else
	SECONDS=0
	snmpwalk -v1 -c $2 $1 .1.3.6.1.2.1.2.2 > /dev/null
       	t1=$SECONDS

	SECONDS=0
	snmpbulkwalk -v2c -c $2 $1 .1.3.6.1.2.1.2.2 > /dev/null
	t2=$SECONDS

	echo "Snmpwalk (ifTable): $t1 (s) "
	echo "Snmpbulkwalk (ifTable): $t2 (s) "	
fi

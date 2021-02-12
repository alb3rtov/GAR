#!/bin/bash
if [[ "$#" -ne 3 ]]
then
	echo "usage: $0 <domain name> <community> <SNMP version>"
else
	output=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.4.1.0)	
	echo $output
	oid=$(echo "$output" | cut -d " " -f1)
	snmpgetnext $3 -c $2 $1 $oid

fi

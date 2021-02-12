#!/bin/bash

snmpwalk() {
	
	snmpget $3 -c $2 $1 $4
	oid=$(echo "$output" | cut -d " " -f1)	
	originalOid=$(echo $4 | cut -d "." -f1-8)
	
	while true;
	do
		output=$(snmpgetnext $3 -c $2 $1 -On $oid 2> /dev/null)	
		oid=$(echo "$output" | cut -d " " -f1)
	
		if [[ "$?" -ne 0 ]] || [[ $oid != *$originalOid* ]]
		then
			break
		fi
			
		snmpget $3 -c $2 $1 $oid
	done
	exit 0
}

if [[ "$#" -ne 4 ]]
then
	echo "usage: $0 <domain name> <community> <SNMP version> <OID>"
else	
	output=$(snmpget $3 -c $2 $1 -On $4.1.0 2> /dev/null)
	
	if [[ "$?" -ne 0 ]]
	then
		output=$(snmpget $3 -c $2 $1 -On $4.0 2> /dev/null)
		
		if [[ "$?" -ne 0 ]]
		then
			echo "Error with de OID"
			exit 1
		else
			echo $output
		fi
	else
		snmpwalk $1 $2 $3 $4.1.0
	fi
fi

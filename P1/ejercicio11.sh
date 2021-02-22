#!/bin/bash

snmpwalk() {

	snmpget $3 -c $2 $1 $4
	oid=$(echo "$output" | cut -d " " -f1)	
	
	while true;
	do
		output=$(snmpgetnext $3 -c $2 $1 -On $oid 2> /dev/null)	
		oid=$(echo "$output" | cut -d " " -f1)
	
		if [[ "$?" -ne 0 ]] || [[ $oid != *$5* ]]
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
	case $3 in
		1)	
			version="-v1"
			;;
		2)
			version="-v2"
			;;
	esac

	output=$(snmpget $version $2 $1 -On $4.1.0 2> /dev/null)
	
	if [[ "$?" -ne 0 ]]
	then
		output=$(snmpget $version -c $2 $1 -On $4.0 2> /dev/null)
		
		if [[ "$?" -ne 0 ]]
		then
			output=$(snmpgetnext $version -c $2 $1 -On $4 2> /dev/null)
			oid=$(echo "$output" | cut -d " " -f1)
			
			if [[ "$?" -ne 0 ]]
			then
				echo "Error with de OID"
				exit 1
			else
				snmpwalk $1 $2 $version $oid $4
			fi
		else
			snmpget $version -c $2 $1 $4.0	
		fi
	else
		snmpwalk $1 $2 $version $4.1.0 $4
	fi
fi

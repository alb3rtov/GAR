#!/bin/bash

snmpwalk() {

	snmpget $3 -c $2 $1 $4
	oid=$(echo "$output" | cut -d " " -f1)	

	fOid="$5.1.x"
	chrlen=${#fOid}
	let division=($chrlen+1)/2

	oNumber=$(echo "$oid" | cut -d "." -f$division)

	while true;
	do
		output=$(snmpgetnext $3 -c $2 $1 -On $oid 2> /dev/null)	
		oid=$(echo "$output" | cut -d " " -f1)
		
		if [[ "$?" -ne 0 ]] || [[ $oid != *$5* ]]
		then	
			break
		fi
	
		fOid="$5.1.x"
		chrlen=${#fOid}
		let division=($chrlen+1)/2

		number=$(echo "$oid" | cut -d "." -f$division)
	
		if [[ "$oNumber" -ne "$number" ]]
		then
			echo "NUeva lista"
			oNumber=$number
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
			output=$(snmpgetnext $3 -c $2 $1 -On $4 2> /dev/null)
			oid=$(echo "$output" | cut -d " " -f1)
			
			if [[ "$?" -ne 0 ]]
			then
				echo "Error with de OID"
				exit 1
			else
				snmpwalk $1 $2 $3 $oid $4
			fi
		else
			snmpget $3 -c $2 $1 $4.0	
		fi
	else
		snmpwalk $1 $2 $3 $4.1.0 $4
	fi
fi

#!/bin/bash

if [[ "$#" -ne 3  ]]
then
	echo "usage: $0 <domain name> <community> <SNMP version>"
else
	SECONDS=0
	octetosin=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.2.2.1.10.6 | awk '{print $4}')
	octetosout=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.2.2.1.16.6 | awk '{print $4}')

	if [[ "$octetosin" -gt "$octetosout" ]]
	then
		octetos=$octetosin
	else
		octetos=$octetosout
	fi

	ifSpeed=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.2.2.1.5.1 | awk '{print $4}')
	duration=$SECONDS

	let "n=octetos*8*100"
	let "n=n/(60*ifSpeed)"
	
	echo $n
fi

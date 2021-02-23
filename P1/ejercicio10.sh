#!/bin/bash

if [[ "$#" -ne 3  ]]
then
	echo "usage: $0 <domain name> <community> <SNMP version>"
else
	SECONDS=0
	octetosinI=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.2.2.1.10.6 | awk '{print $4}')
	octetosoutI=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.2.2.1.16.6 | awk '{print $4}')
	i=$SECONDS

	octetosinJ=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.2.2.1.10.6 | awk '{print $4}')
	octetosoutJ=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.2.2.1.16.6 | awk '{print $4}')
	
	printf "Cargando"
	while [[ $octetosinJ -eq $octetosinI ]]
	do
		octetosinJ=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.2.2.1.10.6 | awk '{print $4}')
		octetosoutJ=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.2.2.1.16.6 | awk '{print $4}')
		printf "."
	done
	
	echo ""

	j=$SECONDS
		
	let "octetosin=octetosinJ-octetosinI"
	let "octetosout=octetosoutJ-octetosoutI"

	if [[ "$octetosin" -gt "$octetosout" ]]
	then
		octetos=$octetosin
	else
		octetos=$octetosout
	fi

	ifSpeed=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.2.2.1.5.1 | awk '{print $4}')
	
	let "time=j-i"
	let "num=octetos*8*100"
	let "dem=time*ifSpeed"
	div=`echo "scale=2; $num/$dem" | bc -l`
	fE=$(echo $div | head -c 1)

	if [[ "$fE" == "." ]]
	then
		echo "0${div} %"
	else
		echo "${div} %"
	fi
fi

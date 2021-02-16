#!/bin/bash

if [[ "$#" -ne 3 ]]
then
	echo "usage: $0 <domain name> <community> <SNMP version>"
else
	ipAddr=$(host $1 | awk '{print $4}')
	mask=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.4.20.1.3.$ipAddr | awk '{print $4}')
	sum=0
	
	for i in 1 2 3 4
	do
		bits=$(echo $mask | cut -d "." -f$i)
		bits=$(echo "obase=2;$bits" | bc)
		
		for j in 0 1 2 3 4 5 6 7 8
		do
			hBits=$(echo ${bits:$j:1})
			let "sum=sum+hBits"
		done
	done
	
	net=$(echo $ipAddr | cut -d "." -f1-3)
	printf "Network address: ${net}.0"
	echo "/$sum"
fi

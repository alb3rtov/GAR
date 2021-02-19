#!/bin/bash

if [[ "$#" -ne 3  ]]
then
	echo "usage: $0 <domain name> <community> <SNMP version>"
else
	ifTable=".1.3.6.1.2.1.2.2.1"
	ipAddrTable=".1.3.6.1.2.1.4.20.1"

	id=$(snmpgetnext $3 -c $2 $1 $ipAddrTable.2 | cut -d " " -f4)


	for j in 1 2 3 4 
	do
		echo "$(snmpget $3 -c $2 $1 $ifTable.2.$id | cut -d " " -f4): "
		printf "\tMac: $(snmpget $3 -c $2 $1 $ifTable.6.$id | cut -d " " -f4)\n"
		printf "\tState: $(snmpget $3 -c $2 $1 $ifTable.8.$id | cut -d " " -f4)\n" 
		printf "\tSpeed: $(snmpget $3 -c $2 $1 $ifTable.5.$id | cut -d " " -f4)\n" 
		printf "\tIn errors: $(snmpget $3 -c $2 $1 $ifTable.14.$id | cut -d " " -f4)\n" 
		printf "\tOut errors: $(snmpget $3 -c $2 $1 $ifTable.20.$id | cut -d " " -f4)\n" 

		ip=$(snmpgetnext $3 -c $2 $1 $ipAddrTable | cut -d " " -f4)
		
		for i in 1 2 3 4
		do
			idIp=$(snmpget $3 -c $2 $1 $ipAddrTable.2.$ip | cut -d " " -f4)

			if [[ "$idIp" -eq "$id" ]]
			then
				printf "\tIp: $(snmpget $3 -c $2 $1 $ipAddrTable.1.$ip | cut -d " " -f4)\n"
				printf "\tMask: $(snmpget $3 -c $2 $1 $ipAddrTable.3.$ip | cut -d " " -f4)\n"
				break
			fi

			ip=$(snmpgetnext $3 -c $2 $1 $ipAddrTable.1.$ip | cut -d " " -f4)
		done
		
		id=$(snmpgetnext $3 -c $2 $1 $ipAddrTable.2.$ip | cut -d " " -f4)

	done
fi

#!/bin/bash

if [[ "$#" -ne 3  ]]
then
	echo "usage: $0 <domain name> <community> <SNMP version>"
else

	printf "%-20s %-20s %-20s" "Destino" "Pasarela" "Genmask"
	oidRouteTable=".1.3.6.1.2.1.4.21"
	destOid=".1.3.6.1.2.1.4.21.1.1"
	destOidAux=$destOid
	maskOid=".1.3.6.1.2.1.4.21.1.7"
	maskOidAux=$maskOid
	nextHopOid=".1.3.6.1.2.1.4.21.1.11"
	nextHopOidAux=$nextHopOid

	for i in 1 2 3 4 5 6 7 8
	do
		dest=$(snmpgetnext $3 -c $2 $1 $destOidAux)
		mask=$(snmpgetnext $3 -c $2 $1 $maskOidAux)
		nextHop=$(snmpgetnext $3 -c $2 $1 $nextHopOidAux)

		destValue=$(echo $dest | cut -d " " -f4)
		maskValue=$(echo $mask | cut -d " " -f4)
		nextHopValue=$(echo $nextHop | cut -d " " -f4)

		printf "\n%-20s" "$destValue"
		printf "%-20s" "$maskValue"
		printf "%-20s" "$nextHopValue"	
		
		destOidAux="${destOid}.${destValue}"
		maskOidAux="${maskOid}.${destValue}"
		nextHopOidAux="${nextHopOid}.${destValue}"

	done

	echo ""
fi

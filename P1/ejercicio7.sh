#!/bin/bash

binaryLength() {
	length=$1
	bits=$2

	if [[ $length -ne "8" ]]
	then
		let "n=8-length"
			
		for (( c=0; c<n; c++))
		do
			bits="0${bits}"
		done
	fi

	echo $bits
}

if [[ "$#" -ne 3 ]]
then
	echo "usage: $0 <domain name> <community> <SNMP version>"
else
	ipAddr=$(host $1 | awk '{print $4}')
	mask=$(snmpget $3 -c $2 $1 .1.3.6.1.2.1.4.20.1.3.$ipAddr | awk '{print $4}')
	sum=0
	
	for i in 1 2 3 4
	do
		bitsIp=$(echo $ipAddr | cut -d "." -f$i)
		bitsIp=$(echo "obase=2;$bitsIp" | bc)
		bitsMask=$(echo $mask | cut -d "." -f$i)
		bitsMask=$(echo "obase=2;$bitsMask" | bc)

		ipLength=${#bitsIp}
		maskLength=${#bitsMask}

		bitsIp=$(binaryLength $ipLength $bitsIp)
		bitsMask=$(binaryLength $maskLength $bitsMask)

		for j in 0 1 2 3 4 5 6 7
		do
			mBits=$(echo ${bitsMask:$j:1})
			ipBits=$(echo ${bitsIp:$j:1})

			if [[ $ipBits -eq "1" ]] && [[ $mBits -eq "1" ]]
			then
				bitsNet="${bitsNet}1"
			else
				bitsNet="${bitsNet}0"
			fi

			let "sum=sum+mBits"
		done
	done

	ini=1
	fin=8

	printf "Network address: "
	
	for l in 0 1 2 3
	do	
		auxBits=$(echo $bitsNet | cut -c $ini-$fin)
		let "ini=ini+8"
		let "fin=fin+8"
		
		if [[ $l -eq 3 ]]
		then
			printf "$((3#$auxBits))"
		else
			printf "$((2#$auxBits))."
		fi
	done	
	
	echo "/$sum"
fi

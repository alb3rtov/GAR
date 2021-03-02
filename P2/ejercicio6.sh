#!/bin/bash

if [[ "$#" -ne 2 ]]
then
	echo "usage: $0 <domain name> <community>"
else
	upTime=$(snmpget -v1 -c $2 $1 .1.3.6.1.2.1.1.3.0 | awk '{print $7}')

	loadmin1=$(snmpget -v1 -c $2 $1 .1.3.6.1.4.1.2021.10.1.3.1 | awk '{print $4}')
	loadmin5=$(snmpget -v1 -c $2 $1 .1.3.6.1.4.1.2021.10.1.3.2 | awk '{print $4}')
	loadmin15=$(snmpget -v1 -c $2 $1 .1.3.6.1.4.1.2021.10.1.3.3 | awk '{print $4}')

	cpuUser=$(snmpget -v1 -c $2 $1 .1.3.6.1.4.1.2021.11.9.0 | awk '{print $4}')
	cpuSystem=$(snmpget -v1 -c $2 $1 .1.3.6.1.4.1.2021.11.10.0 | awk '{print $4}')
	cpuIdle=$(snmpget -v1 -c $2 $1 .1.3.6.1.4.1.2021.11.11.0 | awk '{print $4}')

	memTotalReal=$(snmpget -v1 -c $2 $1 .1.3.6.1.4.1.2021.4.5.0 | awk '{print $4}')
	memAvailReal=$(snmpget -v1 -c $2 $1 .1.3.6.1.4.1.2021.4.6.0 | awk '{print $4}')
	memBuffer=$(snmpget -v1 -c $2 $1 .1.3.6.1.4.1.2021.4.14.0 | awk '{print $4}')
	memCached=$(snmpget -v1 -c $2 $1 .1.3.6.1.4.1.2021.4.15.0 | awk '{print $4}')

	totalSwap=$(snmpget -v1 -c $2 $1 .1.3.6.1.4.1.2021.4.3.0 | awk '{print $4}')
	avalSwap=$(snmpget -v1 -c $2 $1 .1.3.6.1.4.1.2021.4.4.0 | awk '{print $4}')

	printf "$upTime up, load average: $loadmin1, $loadmin5, $loadmin15\n"
	printf "%%Cpu: $cpuUser usuario, $cpuSystem sistema, $cpuIdle idle\n"
	printf "MiB Mem: $memTotalReal total, $memAvailReal disponible, $memBuffer buffer, $memCached cache\n"
	printf "MiB Intercambio: $totalSwap total, $avalSwap disponible\n"
fi

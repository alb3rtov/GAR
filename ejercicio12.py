#!/usr/bin/python3

import sys
from easysnmp import Session

def main():
   
    session = Session(hostname=sys.argv[1], community=sys.argv[2], version=int(sys.argv[3]))
    system_items = session.walk(sys.argv[4])

    for item in system_items:
        print('{0}.{1} {2} = {3}'.format(item.oid, item.oid_index, item.snmp_type, item.value))

if __name__ == "__main__":
    if len(sys.argv) == 5:
        main()
    else:
        print("usage: {0} <domain name> <community> <SNMP version> <OID>".format(sys.argv[0]))


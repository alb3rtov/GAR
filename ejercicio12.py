#!/usr/bin/python3

import sys
from easysnmp import Session

def main():
  
    index_list = []
    items_list = []
    session = Session(hostname=sys.argv[1], community=sys.argv[2], version=int(sys.argv[3]))
    items = session.walk(sys.argv[4])
    index = items[0].oid
    index_list.append(index)
    index2 = index
    cntRows = 0
    cntColumns = 1

    for item in items:
       
        if (item.oid == index):
            cntRows+=1 #Number of the table rows

        if(item.oid != index2):
            cntColumns+=1 #Number of table columns
            index2 = item.oid
            index_list.append(item.oid)

        items_list.append(item.value)
   
    for k in range(len(index_list)):
        print(f'{index_list[k] : <20}', end="")

    print();
    
    for i in range(cntRows):
        for j in range(cntColumns):
            print(f'{items_list[i+cntRows*j] : <20}', end="")
        print("")

if __name__ == "__main__":
    if len(sys.argv) == 5:
        main()
    else:
        print("usage: {0} <domain name> <community> <SNMP version> <OID>".format(sys.argv[0]))

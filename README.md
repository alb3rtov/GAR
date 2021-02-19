# Práctica 1 de Gestión y Administración de Redes
Bash scripts with basic snmp operation (snmpget and snmpgetnext) supported by NET-SNMP

Ejercicio 1. ¿Cómo se puede obtener, a través de SNMP, una información equivalente a la que proporciona el comando # uname -a?
```bash
 snmpget -v1 -c gar tales .1.3.6.1.2.1.1.1.0
```
Ejercicio 2. ¿Cómo se puede obtener, a través de SNMP, una información equivalente a la que proporciona el comando # ifconfig?
```bash
 ./ejercicio2.sh tales.esi.uclm.es gar -v1
```
Ejercicio 3. ¿De qué formas se pueden obtener, a través de SNMP, las direcciones física y lógica de un host?
```bash
 ./ejercicio3.sh tales.esi.uclm.es gar -v1
```
Ejercicio 4. ¿Cómo se puede obtener, a través de SNMP, la máscara de red de un host?
```bash
 ./ejercicio4.sh tales.esi.uclm.es gar -v1
```
Ejercicio 5. ¿Cómo se puede obtener, a través de SNMP, una información equivalente a la que proporciona el comando # netstat -r?
```bash
 ./ejercicio5.sh tales.esi.uclm.es gar -v1
```
Ejercicio 6. ¿Cómo se puede obtener, a través de SNMP, la pasarela de red de un host?
```bash
 ./ejercicio6.sh tales.esi.uclm.es gar -v1
```
Ejercicio 7. ¿Cómo se puede obtener, a través de SNMP, la dirección de la red a la que pertenece un host?
```bash
 ./ejercicio7.sh tales.esi.uclm.es gar -v1
```
Ejercicio 8. ¿Cómo se puede determinar, mediante SNMP, la carga de CPU de un host?
```bash
 ./ejercicio8.sh tales.esi.uclm.es gar -v1****
```
Ejercicio 9. ¿Cómo se puede determinar, mediante SNMP, la memoria principal en uso de un host?
```bash
 snmpget -v1 -c gar tales .1.3.6.1.2.1.25.2.2.0
```
Ejercicio 10. ¿Cómo se puede obtener, mediante SNMP, la utilización de su interfaz de red?
```bash
 ./ejercicio10.sh tales.esi.uclm.es gar -v1****
```
Ejercicio 11. Desarrolle su propio comando snmpwalk (Opcional)
```bash
 ./ejercicio11.sh tales.esi.uclm.es gar -v1 .1.3.6.1.2.1.1
```
Ejercicio 12. Desarrolle su propio comando snmptable (Opcional)

### Python script ejercicio12.py
On Debian / Ubuntu systems:
```bash
 sudo apt-get install libsnmp-dev snmp-mibs-downloader
```
You’ll also need to ensure that you have the following packages installed so that Easy SNMP installs correctly:
```bash
 sudo apt-get install gcc python-dev
```
Then install the libraries for python
```bash
 pip3 install -r requirements.txt
```

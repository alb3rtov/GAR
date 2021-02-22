# Práctica 2 - Utilidades SNMP

Ejercicio 1. Analice el funcionamiento de cada una de las utilidades NET-SNMP (snmpconf, snmpdelta, snmpdf, snmpnetstat, snmptranslate, snmpset, snmpstatus, …). Proponga y resuelva un ejemplo concreto para cada utilidad.


Ejercicio 2. Compare el funcionamiento de snmpwalk y snmpbulkwalk. Emplee ambos comandos para reco-rrer la MIB o alguno de sus grupos. De los datos obtenidos deduzca algunas conclusiones.


Ejercicio 3. Cree estadísticas con el porcentaje de paquetes icmp, ip, snmp, tcp y udp que circulan por la red. De los datos obtenidos deduzca algunas conclusiones.


Ejercicio 4. Configure snmpd.conf utilizando VACM (View Access Control Model), para más información consulte las URLs siguientes (http://www.net-snmp.org/tutorial/tutorial-5/demon/vacm/; http://www.net-snmp.org/wiki/index.php/Vacm), con los siguientes parámetros: SNMP v1 y v2; comunidad private con acceso desde la intranet; una vista denominada todo donde se vea la mib-2; comunidad private con acceso de lectura y escritura en la vista todo.

![alt text](https://i.imgur.com/lZIMXk7.png)

- Address: Direccion/Nombre de dominio.
- Advanced: Configurar la comunidad y el puerto
- File > Load MIBs -> Elegir el MIB deseado
- Para instanciar un objeto, seleccionarlo en el arbol, click derecho y utilizar get, walk, table view...

Ejercicio 5. MIB Browser es la versión gráfica de algunas de las herramientas SNMP analizadas en el labo-ratorio. Para este ejercicio se recomienda el uso de iReasoning MIB Browser que puede encontrar en: http://ireasoning.com/downloadmibbrowserfree.php. Descargue, instale, configure y realice algunos ejemplos.


Ejercicio 6 (OPCIONAL). Implemente una nueva herramienta denominada snmphostats que muestre distin-tas estadísticas (información análoga a la mostrada por el comando top en local) de un agente NET-SNMP. La información necesaria puede obtenerla de UCD-SNMP-MIB (/usr/share/snmp/mibs).

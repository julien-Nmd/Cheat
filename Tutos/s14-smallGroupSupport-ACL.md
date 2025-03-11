
# 1. Définition

ACL = Access Control Lists => ensembles de règles utilisées pour contrôler l'accès aux réseaux et aux sous-réseaux.

**Objectif** : Filtrer le trafic réseau en autorisant ou en bloquant des paquets spécifiques basés sur des critères définis.
**Importance** : Outil essentiel pour la sécurité réseau, le contrôle de trafic, et la segmentation réseau.

2 types :
- **ACL Standard** : Filtrent le trafic basé uniquement sur les adresses IP sources
- **ACL Étendues** : Fournissent des fonctionnalités de filtrage plus détaillées, incluant l'adresse IP source et de destination, les numéros de port, les protocoles, etc.

# 2. Structure des ACL

## a. ACL standard

Ces ACL filtrent le trafic basé sur les adresses des IP sources.

Syntaxe de base :
access-list <**numéro**> <**permission**> <**criteres**>

- Numéro : un numéro entre 1 et 99
- Permissions :
	- **Permit** : Autorise le trafic qui correspond aux critères spécifiés
	- **Deny** : Bloque le trafic correspondant aux critères
- Critères :
	- **host** : pour spécifier une seule adresse IP
	- **any** : désigne tout trafic (toutes les adresses IP possibles) => pour appliquer une ACL sur tout un réseau
	- Adresse IP avec masque de sous-réseau en wildcard. Pour le réseau IP **192.168.10.0/24** on ne mettra pas 192.168.10.0 255.255.255.0, mais **192.168.10.0 0.0.0.255**.

Ordre des Règles : les ACL sont traitées dans l'ordre, de haut en bas

Ex. :
- `access-list 10 deny host 192.168.1.5` => bloque tout le trafic provenant de 192.168.1.5
- `access-list 20 permit 192.168.2.0 0.0.0.255` =>autorise tout le trafic provenant du réseau 192.168.2.0/24
- `access-list 30 deny any` => bloque tout le trafic provenant de n'importe quelle adresse IP
- `access-list 50 deny 172.16.0.0 0.0.255.255` et `access-list 50 permit any` => ACL1 bloque tout le trafic du sous-réseau 172.16.0.0/16 et ACL2 autorise tout autre trafic

## b. ACL étendue

Ces ACL filtrent le trafic basé sur une multitudes de critères.

Syntaxe de base (identique aux ACL standard) :
access-list <**numéro**> <**permission**> <**criteres**>

=> access-list < numero > < permission > < protocole > < src addr >  < src wildcard > < dest addr > < dest wildcard > < operator port >
=> ex. : access-list 101 permit tcp any host 192.168.1.10 eq www

- Numéro : un numéro entre 100 et 199 (chez Cisco)
- Permissions :
	- **Permit** : Autorise le trafic qui correspond aux critères spécifiés
	- **Deny** : Bloque le trafic correspondant aux critères

Les critères sont plus nombreux et plus complexes. On peut trouver :

- **IP source et destination** :
	- **192.168.1.0 0.0.0.255** => réseau source
	- **host 10.0.0.1** => @IP de destination
	- ex.1 : `access-list 101 permit tcp 192.168.1.0 0.0.0.255 host 10.1.1.1 eq 80` => autorise le trafic TCP du réseau 192.168.1.0/24 vers l'adresse IP 10.1.1.1 sur le port 80 (HTTP).
	- ex.2 : `access-list 102 deny icmp 10.0.0.0 0.255.255.255 any` => bloque tout le trafic ICMP provenant du réseau 10.0.0.0/8 vers toutes les destinations.

* **Protocole** :
	* Filtre le trafic par rapport au protocole de couche 3 (IP, ICMP, ...) ou 4 (TCP, UDP, ...)
	* On met le nom du protocole comme `ip`, `icmp`, ...
	* ex.1 : `access-list 110 permit udp any any eq 53` => autorise tout le trafic UDP pour le port 53 (DNS) de n'importe quelle source vers n'importe quelle destination.
	* ex.2 : `access-list 111 deny tcp any host 192.168.1.10 eq 23` => bloque tout le trafic TCP vers l'adresse IP 192.168.1.10 sur le port 23 (Telnet).
	* ex.3 : `access-list 102 deny tcp any host 192.168.1.50 eq 22` => bloquer tout le trafic SSH (port 22) de n'importe quelle source vers l'adresse 192.168.1.50.

* **Port ou plage de ports** :
	* Fonctionne avec les protocoles de couche 4 comme TCP et UDP
	* On met `eq 80` pour le port HTTP, `range 1000 2000` pour une plage de ports
	* ex.1 : `access-list 120 permit tcp any any range 8000 8080` => autorise le trafic TCP pour les ports de 8000 à 8080 de n'importe quelle source vers n'importe quelle destination.
	* ex.2 : `access-list 121 deny udp 192.168.2.0 0.0.0.255 any eq 21` => bloque le trafic UDP pour le port 21 (FTP) provenant du réseau 192.168.2.0/24 vers toutes les destinations.

* **Flags (ou drapeaux)** :
	* Pour les protocoles comme TCP possible de filtrer des flags spécifiques (par exemple, SYN, ACK).
	* Par exemple `established` pour matcher les paquets TCP avec les drapeaux ACK ou RST.
	* ex.1 : `access-list 130 permit tcp any host 10.1.2.3 established` => Autorise les paquets TCP **établis** (avec les drapeaux ACK ou RST) de n'importe quelle source vers l'hôte 10.1.2.3.
	* ex.2 : `access-list 131 deny tcp any any eq 80 ack` => bloque les paquets TCP avec le drapeau ACK sur le port 80 (HTTP) de n'importe quelle source vers n'importe quelle destination.

* **Contrôle de direction** :
	* Spécifie si l'ACL s'applique au trafic entrant (**in**) ou sortant (**out**) sur une interface
	* ex : `ip access-group 101 in` => Applique l'ACL 101 aux paquets entrants sur une interface.

Autres exemples :
- `access-list 141 permit ip 192.168.3.0 0.0.0.255 any ttl eq 200` => autorise le trafic IP du réseau 192.168.3.0/24 vers toutes les destinations avec un Time to Live (TTL) égal à 200.

# 3. Les ACL sur les matériels Cisco

## a. Méthodologie

Il faut :
- Créer une ACL
- Appliquer l'ACL à une interface

## b. Exemple

On veut configurer une ACL pour bloquer tout le trafic provenant de l'adresse IP 192.168.1.100 :

- Créer l'ACL `access-list 110 deny ip 192.168.1.100 0.0.0.255 any`
- Entrer en mode de configuration pour l'interface, par exemple `int g0/0`
- Associer l'ACL avec `ip access-group 110 in`

## c. Vérifier l'application des ACL

Commande `show running-config` ou `sh run` pour voir les ACL dans la conf globale.
Plus précis avec `show access-lists`

# 4. Limites

- Les ACL ne sont pas des firewall, il n'y a pas d'inspection sur l'état des sessions
- Importance de l'ordre des règles et de la mise à jour régulière pour maintenir l'efficacité
- Besoin de surveiller et d'ajuster les ACL pour répondre aux évolutions des menaces et des besoins du réseau

# 5. Pour s'entrainer

## a. ACL simple

- access-list 100 deny icmp 10.1.3.0 0.0.0.255 10.1.2.0 0.0.0.255
Interdit le protocole icmp (donc le ping) du réseau 10.1.3.0/24 vers le réseau 10.1.2.0/24 

- access-list 100 permit icmp 10.1.1.0 0.0.0.255 10.1.2.0 0.0.0.255
Autorise le protocole icmp (donc le ping) du réseau 10.1.1.0/24 vers le réseau 10.1.2.0/24

## b. ACL avec contexte

- Pour le routeur R1 ayant 2 interfaces g0/0 (45.56.12.7/16) sur le WAN  et g1/0 (172.16.15.254/24) sur le LAN  que représente les ACL suivantes :
	- access-list 100 deny icmp any 172.16.15.0 0.0.0.255
	- access-list 100 permit tcp any host 45.56.12.7 eq 80
	- access-list 100 permit tcp any host 45.56.12.7 eq 443
	- access-list 100 permit tcp any host 45.56.12.7 eq 22

`access-list 100 deny icmp any 172.16.15.0 0.0.0.255` => bloque tout le trafic en provenance de n'importe quelle adresse vers le réseau LAN sur le protocole ICMP, donc le ping.

`access-list 100 permit tcp any host 45.56.85.7 eq 80` => autorise depuis n'importe quelle source vers l'adresse 45.56.85.7 le trafic TCP sur le port 80 (HTTP)

`access-list 100 permit tcp any host 45.56.85.7 eq 443` => Comme l'ACL au dessus  mais pour le port 443 (HTTPS)

`access-list 100 permit tcp any host 45.56.85.7 eq 22` => Comme l'ACL au dessus mais pour le SSH

-  Quel est le rôle de l'ACL 101 ?
	- access-list 100 deny icmp host 110.0.0.10 180.0.0.0 0.255.255.255
	- access-list 100 permit ip any any
	- access-list 101 deny tcp host 110.0.0.30 host 220.0.0.60 eq www
	- access-list 101 deny tcp host 180.0.0.30 host 220.0.0.60 eq 443
	- access-list 101 permit ip any any

`access-list 101 deny tcp host 110.0.0.30 host 220.0.0.60 eq www` => bloque le trafic TCP en provenance de l'hôte 110.0.0.30 vers l'hôte 220.0.0.60 sur le port 80 (HTTP)

`access-list 101 deny tcp host 180.0.0.30 host 220.0.0.60 eq 443` => bloque le trafic TCP de l'hôte 180.0.0.30 vers l'hôte 220.0.0.60 sur le port 443 (HTTPS)

`access-list 101 permit ip any any` => permet tout le trafic IP restant de n'importe quelle source vers n'importe quelle destination.
=> ça inclus tous les protocoles ignorés par cette ACL et toutes les autres !

## c. Cas pratique : bloquer l'accès externe à un sous-réseau interne

On veut bloquer l'accès au réseau 192.168.100.0/24.

- Créez une ACL étendue pour bloquer tout trafic entrant depuis l'extérieur vers ce sous-réseau avec `access-list 101 deny ip any 192.168.100.0 0.0.0.255`
- Autorisez tout autre trafic : `access-list 101 permit ip any any`

## d. Cas pratique : sécuriser un serveur interne de l’extérieur

Le serveur a l'adresse IP 192.168.100.10.

- Créer une ACL étendue pour bloquer tout trafic entrant depuis l'extérieur vers l'adresse du serveur : `access-list 102 deny ip any host 192.168.100.10`
- Autorisez tout autre trafic : `access-list 102 permit ip any any`
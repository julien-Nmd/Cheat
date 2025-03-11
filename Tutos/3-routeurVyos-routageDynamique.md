
# 1. Routage RIP

- Activation de RIP sur 2 interfaces `eth0` et `eth1` :
```
set protocols rip interface eth0
set protocols rip interface eth1
```
> On peut mettre autant d'interface que l'on veut (dans la limite matérielle)

- Définir les réseaux à annoncer :
```
# Sur eth0
set protocols rip network 192.168.0.0/24
# Sur eth1
set protocols rip network 192.168.9.0/24
```

> Ne pas oublier de faire `commit`, `save`

- Vérification de la configuration RIP : `show ip rip` (ou `run show ip rip`)

# 2. Routage OSPF

- Activation d'OSPF sur 2 interfaces `eth2` et `eth3` :
```
set protocols ospf area 0.0.0.0 network 172.16.10.0/24
set protocols ospf area 0.0.0.0 network 172.16.15.0/24
set interfaces ethernet eth2 ip ospf area 0.0.0.0
set interfaces ethernet eth3 ip ospf area 0.0.0.0
```

- Configuration de l'ID du routeur OSPF (optionnel) :
```
set protocols ospf parameters router-id 1.1.1.1
```

> Par défaut, VyOS utilise l'adresse IP la plus élevée des interfaces actives comme ID du routeur OSPF.
> On peut la définir manuellement.

- Vérification de la configuration OSPF (en mode standard) :
	- Vérification des interfaces : `show ip ospf interface`
	- Vérification des voisins : `show ip ospf neighbor`
	- Vérification de la table de routage OSPF : `show ip route ospf`
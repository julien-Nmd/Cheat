# 💪Challenge

Sur une VM GNU/Linux (tu peux éventuellement utiliser une [debian](https://www.debian.org/) ou une [Ubuntu](https://ubuntu.com/) voir réutiliser ton serveur DHCP).

- Configure la carte réseau de ta machine virtuelle en "Réseau Interne"
- Mettre en place un serveur DNS sur Linux avec Bind9
- Ce serveur fait autorité sur la zone `wilders.lan`
- Créer un enregistrement de type A et CNAME
- Test le bon fonctionnement du serveur y compris depuis un client sur le réseau local
- Poste une procédure au format markdown permettant pas à pas d'obtenir cette configuration ainsi que les tests associés

# 🧐 Critères d'acceptation

* La zone de recherche se nomme `wilders.lan`
* La résolution d'adresse IP est fonctionnelle (champs A)
* La résolution de l'alias est fonctionnelle (champs CNAME)
* Les tests proposés permettent effectivement de valider les points ci-dessus
* La procédure est claire et permet effectivement lorsqu'elle est appliquée de répondre aux critères du challenge

---

# Configuration d'un serveur DNS avec BIND9 sur Linux


# 1. Installation de Bind9

```bash
apt update
apt install -y bind9 bind9utils bind9-doc dnsutils
```

# 2. Configurer BIND pour faire autorité sur wilders.lan

- Modifier `/etc/bind/named.conf.local` (Zone DNS) :

```conf
zone "wilders.lan" IN {
	type master;
	file "/etc/bind/db.wilders.lan";
	allow-update { none; };
};
```

- Modification du fichier de zone :
```bash
# copie du fichier (sauvegarde) avant modification
cp /etc/bind/db.local /etc/bind/db.wilders.lan
```

Contenu du fichier `/etc/bind/db.wilders.lan` :

```conf
$TTL    604800
@       IN      SOA     ns.wilders.lan. admin.wilders.lan. (
				  2        ; Serial
			 604800        ; Refresh
			  86400        ; Retry
			2419200        ; Expire
			 604800 )      ; Negative Cache TTL
; Nameservers
 @       IN      NS      ns.wilders.lan.

; A record for the DNS server
ns      IN      A       172.16.10.10

; A record for a host
host1   IN      A       172.16.10.20

; CNAME record
www     IN      CNAME   host1.wilders.lan.
```

Pour vérifier la syntaxe des fichiers et de la configuration :

```bash
named-checkconf
named-checkzone wilders.lan /etc/bind/db.wilders.lan
systemctl restart bind9
```

# 3. Test du serveur DNS

## a. Depuis le serveur

```bash
dig @localhost ns.wilders.lan
dig @localhost host1.wilders.lan
dig @localhost www.wilders.lan
```

## b. Depuis un client

```bash
dig @172.16.10.10 ns.wilders.lan
```

Donne 

```bash
[...]
;; ANSWER SECTION:
ns.wilders.lan.		604800	IN	A	172.16.10.10
[...]
```

-> La requête demande l'adresse IP de `ns.wilders.lan` (serveur DNS de la zone).
Résultat : 
- Statut : **NOERROR**
- L'enregistrement A pour `ns.wilders.lan` est configuré et retourne l'adresse IP `172.16.10.10` (@IP du serveur DNS)
=> Fonctionnel

```bash
dig @172.16.10.10 host1.wilders.lan
```

Donne :

```bash
[...]
;; ANSWER SECTION:
host1.wilders.lan.	604800	IN	A	172.16.10.20
[...]
```

-> La requête demande l'adresse IP de `host1.wilders.lan` (serveur DNS de la zone).
Résultat : 
- Statut : **NOERROR**
- L'enregistrement A pour `host1.wilders.lan` est configuré et retourne l'adresse IP `172.16.10.20` (@IP du client)
=> Fonctionnel


```
dig @172.16.10.10 www.wilders.lan
```

Donne :

```bash
[...]
;; ANSWER SECTION:
www.wilders.lan.	604800	IN	CNAME	host1.wilders.lan.
host1.wilders.lan.	604800	IN	A	172.16.10.20
[...]
```

-> La requête demande l'adresse IP de `www.wilders.lan`
- Statut : **NOERROR**
- `www.wilders.lan` est configuré comme un alias (CNAME) pour `host1.wilders.lan`
- `host1.wilders.lan` est bien résolu en adresse IP : `172.16.10.20`
=> Les 2 RR, le CNAME et le A, fonctionnent correctement


# 4. Optionnel

Configuration du fichier `/etc/bind/named.conf.options` :

Si le serveur DNS est autoritaire pour le domaine **wilders.lan** :

```conf
options {
	directory "/var/cache/bind";
    // Autoriser les requêtes DNS uniquement pour les clients locaux
    allow-query { localhost; 172.16.10.0/24; };
    // Interdire la résolution d'autres domaines => interdire la recursivité
    recursion no;
};
```

Si le serveur DNS doit aussi résoudre d'autres domaines exterieurs :

```conf
options {
    directory "/var/cache/bind";
    // Autoriser uniquement les clients locaux à interroger le serveur
    allow-query { localhost; 172.16.10.0/24; };
    // Activer la récursivité pour permettre la résolution externe
    recursion yes;
    // Configurer les forwarders pour les domaines externes
    forwarders {
        9.9.9.9; 8.8.8.8;
    };
};
```

Ne pas oublier de vérifier la syntaxe :

```bash
named-checkconf
systemctl restart bind9
```

# 5. En cas de problèmes

```bash
journalctl -xe
tail -f /var/log/syslog
```


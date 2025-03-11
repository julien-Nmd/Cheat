Démo suite cours :
* IPv6


**radvd** (_Router Advertisement Daemon_) et DHCPv6 sont deux mécanismes pour fournir des informations de configuration réseau aux hôtes dans un réseau IPv6, mais ils fonctionnent différemment.

* **radvd** : 
	* Utilisé pour la découverte de voisins et l'autoconfiguration sans état
	* Envoie des annonces de routeurs qui permettent aux hôtes de générer leurs propres adresses IPv6 en utilisant SLAAC (Stateless Address Autoconfiguration)
* **DHCPv6** :
	* Fournit une configuration d'adresse avec état et peut également fournir d'autres informations de configuration, comme les serveurs DNS
	* Nécessite un serveur central pour gérer les adresses et les options de configuration

=> **radvd** est plus simple à mettre en place


# 1. Configuration des VM

## a. Configuration Virtualbox

**Serveur Debian** : 

* Interface 1 : **NAT** -> enp0s3
* Interface 2 : **Réseau interne** -> enp0s8

**Client** : 

- Interface avec IPv6 activée
- DHCP activé

## b. Configuration IP serveur Debian

- Éditer le fichier `/etc/network/interfaces` et le modifier :

```bash
# The loopback network interface
auto lo
iface lo inet loopback

# Primary network interface
auto enp0s3
iface enp0s3 inet dhcp

# Secondary network interface
auto enp0s8
iface enp0s8 inet static
    address 172.20.0.3
    netmask 255.255.0.0
```

- Redémarrer le service réseau avec `systemctl restart networking`

# 2. Activation routage IPv6

```
# Vérification du statut du forwarding
cat /proc/sys/net/ipv6/conf/all/forwarding
# Activation du routage
echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
```

Pour rendre permanent, editer le fichier `/etc/sysctl.conf` et ajouter : 

```
net.ipv6.conf.all.forwarding=1
```

Appliquer avec `sysctl -p`.


# 3. Installation et configuration

```bash
apt update
apt install radvd
```

Créez le fichier `/etc/radvd.conf` :

```bash
interface enp0s8
{
  # Active l'envoi des annonces routeurs (Router Advertisement ou RA) pour enp0s8
  AdvSendAdvert on;
  # Préfix IPv6 pour les métériels du réseau
  prefix 2001:db8::/64
  {
    # Les @IPv6 du prefixe sont directement accessibles sur le même lien réseau
    AdvOnLink on;
    # Auto-configuration IPv6
    AdvAutonomous on;
  };
};
```

Redémarrer le service avec `systemctl restart radvd`

# 4.  Sur les clients

```
Carte Ethernet Ethernet :

   Suffixe DNS propre à la connexion. . . :
   Description. . . . . . . . . . . . . . : Intel(R) PRO/1000 MT Desktop Adapter
   Adresse physique . . . . . . . . . . . : 08-00-27-A4-DB-87
   DHCP activé. . . . . . . . . . . . . . : Oui
   Configuration automatique activée. . . : Oui
   Adresse IPv6. . . . . . . . . . . . . .: 2001:db8::d65:3af2:a884:c6ca(préféré)
   Adresse IPv6 temporaire . . . . . . . .: 2001:db8::5804:1ebf:1d43:b3fa(préféré)
   Adresse IPv6 de liaison locale. . . . .: fe80::37dc:a487:b166:d6ff%14(préféré)
   Adresse d’autoconfiguration IPv4 . . . : 169.254.140.26(préféré)
   Masque de sous-réseau. . . . . . . . . : 255.255.0.0
   Passerelle par défaut. . . . . . . . . : fe80::a00:27ff:fe6d:745%14
   IAID DHCPv6 . . . . . . . . . . . : 101187623
   DUID de client DHCPv6. . . . . . . . : 00-01-00-01-2D-7B-A9-E8-08-00-27-D2-57-7B
   Serveurs DNS. . .  . . . . . . . . . . : fec0:0:0:ffff::1%1
                                       fec0:0:0:ffff::2%1
                                       fec0:0:0:ffff::3%1
   NetBIOS sur Tcpip. . . . . . . . . . . : Activé
```

`Adresse IPv6. . . . . . . . . . . . . .: 2001:db8::d65:3af2:a884:c6ca(préféré)` => @IPv6 principale de l'interface attribuée par RADVD

`Adresse IPv6 temporaire . . . . . . . .: 2001:db8::5804:1ebf:1d43:b3fa(préféré)` => @IPv6 pour la confidentialité

`Adresse IPv6 de liaison locale. . . . .: fe80::37dc:a487:b166:d6ff%14(préféré)` => @IPv6 auto attribuée par le système pour être sur le LAN (Unicast lien local)

# Ubuntu

## 1. Configuration Adresse IP fixe

Sur Virtualbox, avoir 2 cartes réseaux sur la VM :

* Une en **réseau interne** -> enp0s3
* Une en **NAT** -> enp0s8
### 1.1 En GUI

Sur la VM, en graphique :

* **enp0s3** : 172.20.0.2/16
* **enp0s8** : DHCP

Redémarrer le service avec `sudo systemctl restart NetworkManager`
ou `sudo dhclient -r enp0s3` (pour libérer l'adresse IP actuelle) puis `sudo dhclient enp0s3` 
### 1.2 En CLI - NetPlan

Les fichiers de configuration se trouvent dans `/etc/netplan/`.
Par exemple, `01-network-manager-all.yaml`.
Editer le fichier :

```
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    enp0s3:
      dhcp4: no
      addresses: [172.20.0.3/16]
    enp0s8:
      dhcp4: yes
```

Appliquer les changements avec `sudo netplan apply`.

### 1.3 En CLI - Network Manager

Utilisation de la commande `nmcli`

Exemple :

* pour afficher toutes les connexions : `nmcli con show
* Pour configurer une IP statique : `nmcli con mod "Nom_de_connexion" ipv4.address "172.16.0.3/16" ipv4.method "manual"`

> Les fichiers de configuration des interfaces sont dans `/etc/NetworkManager/system-connections/`.

Appliquer les changements avec `sudo systemctl restart NetworkManager`.

## 2. Définition des interfaces d’écoute DHCP

Sauvegarde fichier original :
```bash
cp /etc/default/isc-dhcp-server /etc/default/isc-dhcp-server.ori
```

Dans le fichier `/etc/default/isc-dhcp-server` mettre `INTERFACESv4="enp0s3"`

## 3. Configuration du DHCP

Editer le fichier `/etc/dhcp/dhcpd.conf` et mettre dedans :

```bash
option domain-name-servers 8.8.8.8;

default-lease-time 3600;
max-lease-time 7200;
authoritative;

subnet 172.20.0.0 netmask 255.255.0.0 {
        range 172.20.0.5 172.20.0.240;
        option subnet-mask      255.255.0.0;
}

host VMClient1 {
        hardware ethernet 08:00:27:A4:DB:87;
        fixed-address 172.20.0.10;
}
```

Démarrage du service :

```bash
sudo systemctl start isc-dhcp-server.service
sudo systemctl enable isc-dhcp-server.service
```

# 2. Debian

## a. Configuration Adresse IP fixe

Sur Virtualbox, avoir 2 cartes réseaux sur la VM :

* Une en **réseau interne** -> enp0s3
* Une en **NAT** -> enp0s8

Avec `ip a` noter les 2 cartes réseaux et éditer le fichier `/etc/network/interfaces` :

```bash
# Primary network interface
auto enp0s3
iface enp0s3 inet static
    address 172.20.0.3
    netmask 255.255.0.0

# Secondary network interface
auto enp0s8
iface enp0s8 inet dhcp
```

> redémarrer le service avec ` systemctl restart networking`

## b. Installation du DHCP

À exécuter :

```bash
apt update
apt install isc-dhcp-server
```

Pour la vérification et le lancement (automatique) :

```bash
systemctl start isc-dhcp-server.service
systemctl status isc-dhcp-server.service
systemctl enable isc-dhcp-server.service
```

## c. Définition des interfaces d’écoute DHCP

Sauvegarde fichier original :
```bash
cp /etc/default/isc-dhcp-server /etc/default/isc-dhcp-server.bkp
```

Dans le fichier `/etc/default/isc-dhcp-server` mettre `INTERFACESv4="enp0s3"`
Commenter la ligne IPV6 si elle n'est pas utilisée.

## d. Configuration du DHCP

Editer le fichier `/etc/dhcp/dhcpd.conf` et mettre dedans :

```bash
option domain-name-servers 8.8.8.8;

default-lease-time 3600;
max-lease-time 7200;
# Si c'est le serveur principal
authoritative;

subnet 172.20.0.0 netmask 255.255.0.0 {
        range 172.20.0.5 172.20.0.240;
        option subnet-mask      255.255.0.0;
}

host VMClient1 {
        hardware ethernet 08:00:27:A4:DB:87;
        fixed-address 172.20.0.10;
}
```

Démarrage du service :

```bash
systemctl start isc-dhcp-server.service
systemctl enable isc-dhcp-server.service
```





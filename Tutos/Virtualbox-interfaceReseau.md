# 1. Carte réseau interne avec IP statique

- 2 VM **Demo1** et **Demo2** avec une carte réseau VirtualBox en **Réseau interne**
- Démarrer les VM
- Faire en sorte d'avoir pour chaque VM :
	- Nom différent : **Demo1** et **Demo2**
	- Configuration IP STATIQUE :
		- VM **Demo1** : IP 172.16.50.50 avec masque de sous-réseaux 255.255.255.0
		- VM **Demo2** : IP 172.16.50.60 avec masque de sous-réseaux 255.255.255.0
		- Ne pas mettre de passerelle par défaut
		- Ne pas mettre de DNS
- Faire un `ping` entre les 2 PC :
```
# Depuis le PC Demo1
ping 172.16.50.60
```

```
# Depuis le PC Demo2
ping 172.16.50.50
```
=> Le ping fonctionne => les 2 PC peuvent communiquer
=> Si le ping ne fonctionne pas => désactiver les pare-feu Windows sur chaque machine
- Faire un ping vers l'exterieur, par exemple l'adresse d'un DNS de Google :
```
# Depuis le PC Demo1
ping 8.8.8.8
```
=> ça ne marche pas car le réseau est fermé et ne peut pas sortir

# 2. Carte réseau interne avec IP dynamique

- Mettre la carte réseau de **Demo2** en IP dynamique :
	- Aller dans la configuration IP et supprimer la configuration mise précédemment
- Redémarrer le PC
- Aller en `cmd.exe` et taper la commande `ipconfig /all`
- Le PC a une adresse IP en **169.254...** c'est une adresse **APIPA** => une adresse IP automatique lorsque une carte réseau ne trouve pas de serveur DHCP
- Faire un ping entre les 2 PC : ça ne marche pas ! => l'adresse IP de **demo2** n'est pas dans la même plage d'adresse IP que **Demo1**
- Faire un ping vers 8.8.8.8 => ça ne marche pas, même raison que tout à l'heure

# 3. Carte réseau en NAT

- Mettre la carte réseau de **Demo2** en **NAT**
- Vérifier que la configuration IP de la VM est bien en DHCP
- Vérifier en `cmd.exe` que la carte réseau a bien une adresse IP => cette adresse IP provient de VirtualBox
- Faire un ping vers 8.8.8.8 => ok
=> Pratique pour un accès internet rapide

# 4. Carte réseau en Pont (Bridge)

- Mettre la carte réseau de **Demo2** en **Pont** et choisir la carte réseau de la machine hôte (filaire ou wifi)
- Vérifier que la configuration IP de la VM est bien en DHCP
- Vérifier en `cmd.exe` que la carte réseau a bien une adresse IP => cette adresse IP provient de la box internet
- Faire un ping vers 8.8.8.8 => ok
- Faire un ping vers la machine hôte => ok
=> Dans ce cas, la VM est considérée sur le même réseau que la machine hôte
=> ATTENTION DANGER en cas de manipulation non-gérée sur la VM => risque d'impact sur les autres matériels réseaux

# 5. Carte réseau en mode Réseau Privé Hôte

- Mettre la carte réseau de **Demo2** en **Host Only**
- Vérifier que la configuration IP de la VM est bien en DHCP
- Vérifier en `cmd.exe` que la carte réseau a bien une adresse IP => cette adresse IP provient de la box internet
- Faire un ping vers 8.8.8.8 => marche pas
- Faire un ping vers la machine hôte => ok
=> Dans ce cas, la VM peut communiquer avec la machine hôte
=> A utiliser pour avoir un réseau fermé qui puisse communiquer avec la machine hôte

# 6. Résumé


| Mode d'accès                  | VM à VM | VM vers hôte | Hôte vers VM | VM vers LAN | LAN vers VM |
| ----------------------------- | ------- | ------------ | ------------ | ----------- | ----------- |
| NAT                           | -       | ok           | -            | ok          | -           |
| Accès par pont (Bridge)       | ok      | ok           | ok           | ok          | ok          |
| Réseau interne                | ok      | -            | -            | -           | -           |
| Réseau privé hôte (Host Only) | ok      | ok           | ok           | -           | -           |
| Réseau NAT                    | ok      | ok           | -            | ok          | -           |

Le mode d'accès **Réseau NAT** est comme le mode **NAT** mais avec la possibilité de joindre les autres VM.

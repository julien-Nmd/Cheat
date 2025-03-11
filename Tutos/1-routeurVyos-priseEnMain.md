
# 1. Connexion

login : vyos
mot de passe : vyos

Affichage du prompt :
```
vyos@vyos:~$
```

# 2. Mode de configuration standard

## a. Entrer dans le mode de configuration

Commande : `configure` ou `conf`
Affichage du prompt :
```
vyos@vyos#
```

Exemple de configuration :
- Mettre le clavier en Français : `set system option keyboard-layout fr`

## b. Valider et sauvegarder la configuration

```
# Valider
commit

# Sauvegarder
save

# Quitter le mode de configuration
exit
```

# 3. Configurer les interfaces réseau

- Entrer en mode de configuration (`conf`)
- Pour créer une interface (liée à une carte `vmbr`) :
```
set interfaces ethernet eth<Numéro> address <AdresseDeLInterface>
```
- Exemple 1 : Configurer `vmbr8` (correspondant à `eth0` par exemple) avec l'adresse IP `192.168.0.250/24` :
```
set interfaces ethernet eth0 address 192.168.0.250/24
```
- Exemple 2 : Configurez `vmbr10` (correspondant à `eth1` par exemple) avec l'adresse IP `192.168.9.250/24` :
```
set interfaces ethernet eth1 address 192.168.9.250/24
```
- Faire `commit` et `save` pour sauvegarder la configuration

# 4. Suppression d'interface

- Exemple pour supprimer l'interface `eth0`
```
delete interfaces ethernet eth0
```
- Faire `commit` et `save` pour sauvegarder la configuration

# 5. Autres commandes

- Pour afficher les interfaces :
```
show interfaces
```
- Redémarrer le routeur :  `sudo reboot`
- Éteindre le routeur : `sudo poweroff`

> ATTENTION de bien sauvegarder avec `save` avant !

# 1. Prérequis

1 VM Debian 12 avec au moins 1 carte réseau sous VirtualBox :
- En **NAT**, faire une redirection de port pour le SSH (**PAT**)
- En **Host Network** (! Attention dans ce cas pas d'accès à Internet)
Test de connexion en ssh sur la VM à partir de l'ôte.

Avoir un compte **wilder** dans le groupe sudo.

# 2. Journaux systèmes

## a. Liste des journaux

Sous **/var/log** :
```
alternatives.log       alternatives.log.3.gz  apt     dpkg.log       dpkg.log.3.gz  dpkg.log.6.gz  journal  README               vboxadd-setup.log
alternatives.log.1     alternatives.log.4.gz  btmp    dpkg.log.1     dpkg.log.4.gz  faillog        lastlog  runit                vboxadd-setup.log.1
alternatives.log.2.gz  alternatives.log.5.gz  btmp.1  dpkg.log.2.gz  dpkg.log.5.gz  installer      private  vboxadd-install.log  wtmp
```

Liste des journaux :
- alternatives.log : MAJ des liens symboliques, ...
- dpkg.logg : journal de dpkg
 
- wtmp : connexion/deconnexion des utilisateurs + démarrage/redémarrage système (commande `last`)
- btmp : comme **wtmp** mais pour les echec de connexion (commande `lastb`)
- faillog : echecs de connexion, comme erreur mot de passe (commande `faillog`)

Utilisable directement :

```bash
cat /var/log/dpkg.log
cat /var/log/alternatives.log

ls /var/log/journal/
# contient un fichier binaire de journalisation
```

## b. Journal syslog

Sur Debian 12 il faut l'installer (déjà installé sous Ubuntu) :

```bash
apt update
apt upgrade -y
apt install rsyslog -y
systemctl enable rsyslog
```

**rsyslog** : Implémentation moderne de syslog.

Commandes associées :
- **logger** : Pour envoyer des messages au démon syslog/rsyslog
- **journalctl** : Pour afficher les journaux gérés par **journald** (système de logs utilisé par systemd)

Une fois installé, d'autres journaux disponibles :

- cron.log : journal de crontab
- kern.log : message du noyau
- user.log : journal liés aux applications de l'utilisateur
- auth.log : journal authentifiation (ssh, sudo, ...)
- syslog : journal principal

Utilisable directement :

```bash
cat /var/log/syslog
grep "ssh" /var/log/syslog

# erreur système ou service
cat /var/log/syslog | grep -i "error"
cat /var/log/syslog | grep -i "fail"

# suivi d'évenements réseau
cat /var/log/syslog | grep -i "network"
cat /var/log/syslog | grep -i "dhclient"

# suivi d'un service
cat /var/log/syslog | grep -i "cron"
```

## c. La commande tail

=> Pour afficher les dernières lignes d'un fichier ==> surveiller les fichiers de logs (nouvelles entrées sont généralement ajoutées à la fin du fichier)

- Afficher les 10 dernières lignes d'un fichier : `tail /var/log/syslog`
- Afficher 15 dernières lignes d'un fichier : `tail -n 15 /var/log/syslog`
- Affichage en temps réel : `tail -f /var/log/syslog`
- Afficher 15 dernières lignes d'un fichier en temps réel : `tail -n 15 -F /var/log/syslog`

## d. La commande logger

=> Pour ajouter un message à syslog

- Ajouter un message : `logger "Ceci est un test de message de log"`
- Ajouter un message avec avec une priorité spécifique : `logger -p local0.info "Ceci est un message d'information"`

Détail des priorités :
- `local0.info` => `<facility>.<level>`
	- `facility` :  catégorie de message :
		- `auth`
		- `cron`
		- `daemon`
		- `kern`
		- `user`
		- `syslog`
		- `mail`
		- `local0` à `local7` ...
	- `level` : criticité :
		- `emerg` (ou `emergency`)
		- `alert`
		- `crit` (ou `critical`)
		- `err` (ou `error`)
		- `warning`
		- `notice`
		- `info`
		- `debug`

# 3. Commande journalctl

## a. Utilisation standard

Pas sous fichiers texte => inclus (format binaire) dans **systemd-journald**.

Journaux temporaires sous `/run/log/journal/`
Persistent (si configurés) sous `/var/log/journal/`

- Commande standard : ` journalctl`
- Avec informations détaillées : `journalctl -o verbose`
- Avec informations de criticité : `journalctl -p <err>` (avec `<err>` lettre ou chiffre)
	- ex.1 : `journalctl -p 2`  -> criticité 0 et 1 et 2
	- ex.2 : `journalctl -p x..x` -> uniquement criticité entre x et x

Niveau de criticité :
- 0 : emerg (urgence)
- 1 : alert (alerte)
- 2 : crit (critique)
- 3 : err (erreur)
- 4 : warning (avertissement)
- 5 : notice (notification)
- 6 : info (information)
- 7 : debug (débogage)

## b. Affichage différent avec le JSON

- Affichage en JSON (JavaScript Object Notation) : `journalctl -o json-pretty`

> JSON : Format de données léger et facile à lire pour les humains.
> Utilisé pour structurer et échanger des données entre un serveur et un client (ou entre différentes parties d'une application).
> Dérivé de la syntaxe du langage de programmation JavaScript ==> mais indépendant du langage et est largement utilisé dans divers langages de programmation.
> Qq exemples : https://json.org/example.html .

- Niveau de criticité avec affichage JSON :`journalctl -p err -o json-pretty`

## c. Utilisation de l'utilitaire jq pour le json

- **jq** : permet de manipuler et filtrer les données JSON de manière conviviale :
```bash
journalctl -p err -o json-pretty | jq -r '"\(.PRIORITY) - \(.__REALTIME_TIMESTAMP) - \(.SYSLOG_IDENTIFIER): \(.MESSAGE)"'
```

- Pour horodatage plus clair : 
```bash
journalctl -p err -o json-pretty | jq -r '"\(.PRIORITY) - \((.__REALTIME_TIMESTAMP | tonumber / 1000000) | strftime("%Y-%m-%d %H:%M:%S")) - \(.SYSLOG_IDENTIFIER): \(.MESSAGE)"' 
```

Explication :
- `-r` : sortie "raw" (brute) ==> la sortie ne sera pas entourée de guillemets doubles ==> plus lisible et facile à traiter par d'autres outils en ligne de commande. 
- `(.PRIORITY)…` : modèle de chaîne de caractères 
- `strftime`: fonction pour convertir le champ `__REALTIME_TIMESTAMP` en une chaîne de caractères formatée représentant la date et l'heure
- => Le format utilisé ici est "AAAA-MM-JJ HH:MM:SS" (=> ajustable en fonction)

## d. Stockage et lecture des enregistrements de logs

- Enregistrement des logs avec des niveaux de criticité de 0 à 3 :
```bash
journalctl -q -p 0..3 -o json-pretty > ~/critical_logs.json
```

- Lecture des logs avec le script **readLogs.sh** : 
```bash
#!/bin/bash

if [ $# -ne 2 ]
then
    echo -e "Manque d'arguments :\nArgument 1 : Criticité\nArgument 2 : Fichier de logs"
    exit 1
fi

criticity_level=$1
logs_file=$2

cat $logs_file | jq -r '"\(.PRIORITY) - \((.__REALTIME_TIMESTAMP | tonumber / 1000000) | strftime("%Y-%m-%d %H:%M:%S")) - \(.SYSLOG_IDENTIFIER): \(.MESSAGE)"' | grep "^$criticity_level -"
```

# 4. Utilisation de crontab

Aide à cron : https://crontab.guru/
Suivi web : https://cronitor.io/

- Éditeur tâches : `crontab –e`
- Ajouter ça à la fin du fichier :
```bash
*/10 * * * * journalctl -q -p 0..4 -o json-pretty > ~/critical_logs_$(date +\%Y\%m\%d\%H\%M).json
```
==> cron exécutera désormais la commande toutes les 10 minutes, enregistrant les logs de criticité 0 à 3 dans un fichier JSON avec un horodatage dans le répertoire courant de l'utilisateur.

Gestion par script **readAdvancedLogs.sh** :
```bash
#!/bin/bash 

# Variables
log_directory="/home/wilder/Documents/saveLogs"

# Vérification du nombre d'arguments
if [ "$#" -ne 2 ]
then
	echo -e "Arguments manquants :\nArgument 1 : <criticite>\nArgument 2 : <date_heure> (format AAAAMMJJHHMM)"
	exit 1
fi 

# Récupération des arguments
criticite=$1 
date_heure=$2 

# Vérification de la validité des arguments
if ! [[ $criticite =~ ^[0-3]$ ]]
then
	echo "Erreur: la criticite doit etre un nombre entier entre 0 et 3"
	exit 1
fi

if ! [[ $date_heure =~ ^[0-9]{12}$ ]]
then
	echo "Erreur: la date_heure doit etre au format AAAAMMJJHHMM"
	exit 1
fi

# Recherche du fichier de log le plus proche de l'horodatage fourni
closest_log_file=$(ls $log_directory | grep "^critical_logs_" | sort | awk -v target="$date_heure" 'BEGIN {closest_diff = 9999999999} {current_diff = (target - substr($0, 15, 12)) ^ 2; if (current_diff < closest_diff) {closest_diff = current_diff; closest_log = $0}} END {print closest_log}') 
  
# Vérification de l'existence du fichier de log
if [ -z "$closest_log_file" ]
then
	echo "Aucun fichier de log trouvé correspondant à la date et l'heure fournies"
	exit 1
fi

# Affichage du contenu du fichier de log correspondant à la criticité demandée
log_file_path="$log_directory/$closest_log_file"
echo "Affichage des entrées de criticité $criticite pour le fichier de log $closest_log_file :"
cat $log_file_path | jq ". | select(.PRIORITY == \"$criticite\")"
```

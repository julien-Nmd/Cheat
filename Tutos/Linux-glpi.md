
# 1. Sur le serveur Debian 12

## a. Apache

```Bash
# MAJ
apt update && apt upgrade -y

# Installation Apache
apt install apache2 -y

# Activation d'Apache au démarrage de la machine
systemctl enable apache2
```

## b. MariaDB

```Bash
# Installation de la BDD
apt install mariadb-server -y
```

## c. PHP

```Bash
# Installation des dépendances
apt install ca-certificates apt-transport-https software-properties-common lsb-release curl lsb-release -y

# Ajout du dépôt pour PHP 8.1 :
# wget -qO /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
# echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
curl -sSL https://packages.sury.org/php/README.txt | bash -x
apt update

# Installation de PHP 8.1
apt install php8.1 -y

# Installation des modules annexes
apt install php8.1 libapache2-mod-php -y

apt install php8.1-{ldap,imap,apcu,xmlrpc,curl,common,gd,mbstring,mysql,xml,intl,zip,bz2} -y
```

## d. MariaDB

```Bash
# Installation de Mariadb
mysql_secure_installation
```

À part `Change the root password?`, répondre `Y` à toutes les questions.

```Bash
# Configuration de la base de données
mysql -u root -p
```

Dans la configuration de Mariadb, mettre :

```sql
# Nom de la BDD : glpidb
create database glpidb character set utf8 collate utf8_bin;

# Compte d accès à la BDD glpidb : glpi
# mot de passe du compte glpi : Azerty1*
grant all privileges on glpidb.* to glpi@localhost identified by "Azerty1*";

flush privileges;
quit
```

## d. Ressources de GLPI dans Github

```Bash
# Téléchargement des sources
wget https://github.com/glpi-project/glpi/releases/download/10.0.15/glpi-10.0.15.tgz

# Création du dossier pour glpi
mkdir /var/www/html/glpi.lab.lan

# Décompression du contenu téléchargé
tar -xzvf glpi-10.0.15.tgz

# Copie du dossier décompréssé vers le nouveau crée
cp -R glpi/* /var/www/html/glpi.lab.lan

# Suppression du fichier index.php dans /var/www/html
rm /var/www/html/index.html

# Droits d'accès aux fichiers
chown -R www-data:www-data /var/www/html/glpi.lab.lan
chmod -R 775 /var/www/html/glpi.lab.lan
```

## e. Configuration de PHP

```bash
# Edition du fichier /etc/php/8.1/apache2/php.ini
nano /etc/php/8.1/apache2/php.ini
```

Modification des paramètres :
```c
memory_limit = 64M # <= à changer
file_uploads = on
max_execution_time = 600 # <= à changer
session.auto_start = 0
session.use_trans_sid = 0
```

Redémarrer le serveur.

# 2. À partir d'une machine graphique

Sur un navigateur web :
http://`<Adresse IP du serveur GLPI>`/glpi.lab.lan/

Sur la page d'installation :
- Langue : **Français**
- Cliquer sur **Installer**
- Corriger éventuellement les **requis**

Pour le SETUP :
- Serveur SQL : `127.0.0.1` ou `localhost`
- Utilisateur : `glpi`
- Mot de passe : `Azerty1*`

Choisir la base de données créer : `glpidb`

```
Les identifiants et mots de passe par défaut sont :

- glpi/glpi pour le compte administrateur
- tech/tech pour le compte technicien
- normal/normal pour le compte normal
- post-only/postonly pour le compte postonly
```

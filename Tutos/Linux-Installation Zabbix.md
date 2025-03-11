# Installation des Dépendances

```bash
apt install sudo gpg curl wget
```

# Installation de PostgreSQL

Dans un premier temps, nous allons installer les dépôts PostgreSQL et désactiver les dépôts PostgreSQL système par défaut. Lorsque le message suivant apparaît :
**« Ce script activera le dépôt APT PostgreSQL sur apt.postgresql.org sur votre système. Le nom de code de la distribution utilisé sera bookworm-pgdg. »**
appuyez sur **Entrée** pour continuer et confirmer l'installation depuis le dépôt officiel.

```bash
apt install -y postgresql-common
/usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
```

Ensuite, nous installons PostgreSQL, ici dans sa version actuellement prise en charge, la version 17.

```bash
apt -y install postgresql-17
```

Lancer PostgreSQL et configurer son démarrage automatique au démarrage du système :

```bash
systemctl enable postgresql --now
```

# Installation du Serveur Zabbix et de ses Composants

La base de données étant maintenant installée, nous pouvons procéder à l'installation du serveur Zabbix et de tous ses composants.

Ajoutons les dépôts Zabbix et vidons le cache d'installation.

```bash
wget https://repo.zabbix.com/zabbix/7.2/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.2+debian12_all.deb
dpkg -i zabbix-release_latest_7.2+debian12_all.deb
apt update
```

Nous installons tous les composants nécessaires de Zabbix.

Dans ce cas, nous utiliserons Zabbix Agent 2 comme agent principal de supervision, recommandé pour ses nombreuses fonctionnalités supplémentaires.

```bash
apt install zabbix-server-pgsql zabbix-frontend-php php8.2-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent2 zabbix-web-service
```

# Initialisation de la Base de Données

Commencez par créer un utilisateur de base de données pour Zabbix. Pendant le processus, un mot de passe d'accès sera demandé. Ensuite, créez une base de données vide et attribuez les autorisations nécessaires.

```bash
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
```

À ce stade, nous pouvons importer le schéma et les données par défaut. Le mot de passe saisi précédemment sera de nouveau demandé.

```bash
zcat /usr/share/zabbix/sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
```

# Installation de TimescaleDB

Procédons à l'installation de TimescaleDB en ajoutant d'abord son dépôt officiel.

```bash
curl -s https://packagecloud.io/install/repositories/timescale/timescaledb/script.deb.sh | sudo bash
```

Installez TimescaleDB :

```bash
apt install timescaledb-2-postgresql-17 timescaledb-2-loader-postgresql-17
```

Exécutez l'utilitaire `timescaledb-tune`, en définissant une valeur plus élevée pour le nombre maximum de connexions (`--max-conns`), ici 125 pour des tests. 

Cet utilitaire ajuste les paramètres par défaut de PostgreSQL pour optimiser les performances et configure correctement les paramètres de PostgreSQL afin de fonctionner avec TimescaleDB.

De plus, l’utilitaire nous aidera à sélectionner le fichier de configuration PostgreSQL actuel et valide, et configurera automatiquement le chargement des bibliothèques TimescaleDB.

Veuillez répondre **"oui"** (`y`) à toutes les questions. Notez que le tuner automatique suppose que PostgreSQL fonctionne sur un serveur dédié, donc certains paramètres peuvent nécessiter des ajustements.


```bash
timescaledb-tune --pg-config /usr/bin --max-conns=125
```

Redémarrez ensuite le service PostgreSQL :

```bash
systemctl restart postgresql
```

Créez et activez TimescaleDB :

```bash
echo "CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;" | sudo -u postgres psql zabbix
cat /usr/share/zabbix/sql-scripts/postgresql/timescaledb/schema.sql | sudo -u zabbix psql zabbix
```

# Configuration du Serveur Zabbix

Ouvrez le fichier de configuration du serveur Zabbix situé à :

```bash
nano /etc/zabbix/zabbix_server.conf
```

Modifiez les paramètres suivants comme indiqué ci-dessous :

```bash
...
DBPassword=motdepasse
StartReportWriters=1
WebServiceURL=http://localhost:10053/report
...
```

Configurez les packages linguistiques pour l'interface de Zabbix :

```bash
sed -i '/# fr_FR.UTF-8 UTF-8/s/^# //' /etc/locale.gen
sed -i '/# en_US.UTF-8 UTF-8/s/^# //' /etc/locale.gen
locale-gen
```

Redémarrez les services liés et configurez-les pour un démarrage automatique :

```bash
systemctl restart zabbix-server zabbix-web-service zabbix-agent2 apache2
systemctl enable zabbix-server zabbix-web-service zabbix-agent2 apache2
```

# Configuration de l'Interface de Zabbix

Dans votre navigateur, accédez à l'URL cible où Zabbix est en cours d'exécution, par exemple `http://192.168.0.50/zabbix`. Suivez l'assistant d'installation initiale pour configurer les paramètres requis, tels que la connexion à la base de données et les informations de base sur le serveur.

Connectez-vous ensuite avec les identifiants par défaut (**Admin/zabbix**) pour accéder au tableau de bord initial.

 Après avoir sélectionné la langue par défaut, cliquez sur **Étape suivante** pour accéder à la page de vérification des prérequis minimaux.

![](https://www.initmax.com/wp-content/uploads/2024/12/zabbix72install1.png)

Si la vérification est réussie, cliquez sur **Étape suivante** pour accéder à la page des paramètres de connexion à la base de données.

![](https://www.initmax.com/wp-content/uploads/2023/10/zabbix70-2.png)

Ici, remplissez uniquement le champ **Mot de passe** pour accéder à la base de données ; aucune autre modification n'est nécessaire.

Après avoir saisi le mot de passe, cliquez de nouveau sur **Étape suivante**.

![](https://www.initmax.com/wp-content/uploads/2023/10/zabbix70-3.png)

Sur la page suivante, dédiée aux paramètres de base, renseignez le nom du serveur et le fuseau horaire, puis cliquez sur **Étape suivante** pour accéder au résumé de la configuration.
A
![](https://www.initmax.com/wp-content/uploads/2023/10/zabbix70-4.png)

Dans ce résumé, examinez toutes les valeurs saisies, puis cliquez sur **Étape suivante** pour terminer l'installation.

![](https://www.initmax.com/wp-content/uploads/2023/10/zabbix70-5.png)

Enfin, cliquez sur le bouton **Terminer** pour accéder à l'écran de connexion.

![](https://www.initmax.com/wp-content/uploads/2023/10/zabbix70-6.png)

Après vous être connecté avec les identifiants précédemment configurés, vous pouvez commencer à utiliser la dernière version de Zabbix 7.2 (**Admin/zabbix**).

![](https://www.initmax.com/wp-content/uploads/2023/10/zabbix70-7.png)

Voici à quoi ressemble le tableau de bord initial de la nouvelle version de Zabbix 7.2 :

![](https://www.initmax.com/wp-content/uploads/2024/12/zabbix72dashboard.png)




---

# Installation et Configuration de Zabbix-agent2 sur Linux

## Installation

Vous pouvez installer le Zabbix-agent2 avec la commande suivante :

```bash
apt install zabbix-agent2
```

## Configuration de l'agent

Pour faire fonctionner l'agent, vous devez configurer certains paramètres de base.

Pour cela, ouvrez le fichier `zabbix_agent2.conf` avec votre éditeur de texte préféré :

```bash
nano /etc/zabbix/zabbix_agent2.conf
```

Ajustez les propriétés suivantes :

```plaintext
Server=<Indiquez ici le nom d'hôte de votre serveur ZABBIX>
ServerActive=<Indiquez ici le nom d'hôte de votre serveur ZABBIX>
Hostname=<Indiquez ici le nom d'hôte de votre serveur ACTUEL>
```

## Redémarrer Zabbix-agent2

Pour appliquer vos paramètres, redémarrez le Zabbix-agent2 avec la commande suivante :

```bash
systemctl restart zabbix-agent2
```


---

# Installation de Zabbix-Agent sur Windows

## Récupération des sources d'installation

Pour télécharger le fichier d'installation .msi de l'agent suivre ce lien : [Agent 2]( https://cdn.zabbix.com/zabbix/binaries/stable/7.2/7.2.2/zabbix_agent2-7.2.2-windows-amd64-openssl.msi)

## Installation de Zabbix Agent 2

Lancer l'installation, accepter les CGU, laisser tous les composants enfichables.

## Configuration du service 

Indiquer le Hostname du serveur sur lequel vous êtes (souvent remplis par défaut).

- Saisir l'IP du server ZABBIX.
- Laisser le port par défaut.
- Saisir l'IP du server ZABBIX.
- Cocher **Add agent location to the PATH**


Terminer ensuite l'installation. 

## Vérification du service

Afin de s'assurer que l'installation s'est correctement effectuée et que le service est bien lancé aller regardez dans les services Windows si il est bien lancé. 


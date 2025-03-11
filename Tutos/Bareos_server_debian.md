# Guide d'Installation et de Configuration de Bareos Community sur Debian

Ce guide détaille l'installation de **Bareos Community Edition** sur une distribution Debian, ainsi que sa configuration initiale pour une utilisation fonctionnelle.

## 1. Installation de PostgreSQL sur Debian

Bareos utilise **PostgreSQL** pour sa base de données. Voici comment installer et configurer PostgreSQL.

### 1.1. Installation de PostgreSQL

1. Mettez à jour les paquets du système :

    ```bash
    apt update && apt upgrade -y
    ```

2. Installez PostgreSQL et ses outils supplémentaires :

    ```bash
    apt install postgresql postgresql-contrib -y
    ```

3. Assurez-vous que le service PostgreSQL démarre automatiquement au démarrage du système :

    ```bash
    systemctl enable postgresql
    systemctl start postgresql
    ```

4. Vérifiez que PostgreSQL fonctionne correctement :

    ```bash
    systemctl status postgresql
    ```

## 2. Installation de Bareos sur Debian

### 2.1. Prérequis

Assurez-vous que votre système est à jour avant de procéder à l'installation :

```bash
apt update && apt upgrade -y
```

Installation de GPG (gnupg):

```bash
apt install gnupg -y
```reboot

### 2.2. Ajouter le Dépôt Bareos et Définir les Permissions

1. Téléchargez le script d’ajout des dépôts Bareos :

    ```bash
    wget https://download.bareos.org/current/Debian_12/add_bareos_repositories.sh
    ```

2. Donnez les droits d’exécution au script :

    ```bash
    chmod +x add_bareos_repositories.sh
    ```

3. Exécutez le script pour ajouter les dépôts Bareos :

    ```bash
    sh ./add_bareos_repositories.sh
    ```

4. Mettez à jour la liste des paquets :

    ```bash
    apt update
    ```

### 2.3. Installer les Méta-Paquets Bareos

1. Installez Bareos avec PostgreSQL :

    ```bash
    apt install bareos bareos-database-postgresql -y
    ```

    Cela inclut les composants suivants :
    - Bareos Director.
    - Bareos Storage Daemon.
    - Bareos File Daemon.
    - Outils CLI.
    - Configuration pour PostgreSQL.

### 2.4. Configurer les Scripts de Base de Données

1. Les scripts nécessaires sont installés dans `/usr/lib/bareos/scripts/`. Donnez-leur les permissions nécessaires :

    ```bash
    chmod +x /usr/lib/bareos/scripts/*
    ```

2. Exécutez les scripts avec l’utilisateur `postgres` :

    ```bash
    su - postgres -c "/usr/lib/bareos/scripts/create_bareos_database"
    su - postgres -c "/usr/lib/bareos/scripts/make_bareos_tables"
    su - postgres -c "/usr/lib/bareos/scripts/grant_bareos_privileges"
    ```

3. Vérifiez que la base de données a été correctement configurée :

    ```bash
    psql -U bareos -d bareos -c '\dt'
    ```
    Cela devrait afficher les tables créées par Bareos.

### 2.5. Configurer l'authentification PostgreSQL pour Bareos

Par défaut, PostgreSQL utilise l'authentification `peer`, ce qui peut provoquer une erreur pour l'utilisateur `bareos`. Voici comment configurer l'authentification `md5` (mot de passe) :

1. Modifiez le fichier de configuration `pg_hba.conf` :

    ```bash
    nano /etc/postgresql/XX/main/pg_hba.conf
    ```
    (Remplacez `XX` par la version de PostgreSQL installée, par exemple `15`.)

2. Recherchez les lignes correspondant à `bareos` ou à `all` et modifiez-les comme suit :

    ```plaintext
    # Avant :
    local   all             bareos                                  peer

    # Après :
    local   all             bareos                                  md5

    # Modifier également la ligne "local" is for Unix... de la même manière
    ```

3. Redémarrez PostgreSQL pour appliquer les changements :

    ```bash
    systemctl restart postgresql
    ```

4. Définissez un mot de passe pour l'utilisateur `bareos` :

    ```bash
    su - postgres -c "psql -c \"ALTER USER bareos WITH PASSWORD 'votre_mot_de_passe';\""
    ```

5. Testez la connexion avec l'utilisateur `bareos` :

    ```bash
    psql -U bareos -d bareos -W
    ```
    PostgreSQL demandera le mot de passe que vous venez de définir.

## 3. Configuration et Démarrage de Bareos

### 3.1. Démarrer et Activer les Services

1. Démarrez et activez les services Bareos :

    ```bash
    systemctl enable --now bareos-director
    systemctl enable --now bareos-storage
    systemctl enable --now bareos-filedaemon
    ```

2. Vérifiez l’état des services :

    ```bash
    systemctl status bareos-director bareos-storage bareos-filedaemon
    ```

### 3.2. Tester avec bconsole

- Lancez `bconsole` pour vérifier le bon fonctionnement de Bareos :

    ```bash
    bconsole
    ```

- Essayez des commandes comme :

    ```bash
    *status director
    ```

    Cela confirmera que le Bareos Director est opérationnel.

---

Avec cette installation et configuration, Bareos est fonctionnel avec PostgreSQL. Vous pouvez passer à l’étape suivante pour configurer l’interface WebUI ou les sauvegardes personnalisées.

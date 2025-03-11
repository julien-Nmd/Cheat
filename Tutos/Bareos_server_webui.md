# Guide de Configuration de l'Interface WebUI de Bareos sur Debian/Ubuntu

Ce guide adapte la documentation officielle de **Bareos WebUI** pour Debian et Ubuntu afin de garantir un fonctionnement optimal.

## 1. Installation de Bareos WebUI

### 1.1. Installer Bareos WebUI

1. Installez le méta-paquet `bareos-webui` :
    ```bash
    apt-get install bareos-webui -y
    ```

2. Activez le support PHP-FPM pour Apache :
    ```bash
    a2enmod proxy_fcgi setenvif
    a2enconf php8.2-fpm
    systemctl reload apache2
    ```
    > Remplacez `php8.2-fpm` par la version de PHP-FPM installée sur votre système.

3. Vérifiez que le service PHP-FPM est actif :
    ```bash
    systemctl enable php8.2-fpm
    systemctl start php8.2-fpm
    ```
4. On vérifie avec `systemctl status php8.2-fpm`

5. On redémarre le service bareos:
    ```bash
    systemctl restart bareos-director
    ```
    
---

## 2. Configuration Minimale

### 2.1. Créez un utilisateur Bareos pour WebUI

Vous avez deux méthodes pour configurer un utilisateur Bareos pour la WebUI :

#### **Méthode 1 : Utiliser `bconsole`**

1. Connectez-vous à `bconsole` :
    ```bash
    bconsole
    ```

2. Créez un utilisateur nommé `admin` avec un mot de passe :
    ```plaintext
    *configure add console name=admin password=secret profile=webui-admin tlsenable=false
    *reload
    ```
    > Remplacez `secret` par un mot de passe sécurisé de votre choix.

3. Quittez `bconsole` :
    ```plaintext
    *exit
    ```

4. Si cela ne fonctionne pas, vérifiez que le profil `webui-admin` est défini :
    - Accédez à `/etc/bareos/bareos-dir.d/profile/`.
    - Si le fichier `webui-admin.conf` n'existe pas, créez-le avec le contenu suivant :
      ```plaintext
      Profile {
          Name = webui-admin
          CommandACL = !.bvfs_clear_cache, !.exit, !.sql, !configure, !create, !delete, !purge, !sqlquery, !umount, !unmount, *all*
          Job ACL = *all*
          Schedule ACL = *all*
          Catalog ACL = *all*
          Pool ACL = *all*
          Storage ACL = *all*
          Client ACL = *all*
          FileSet ACL = *all*
          Where ACL = *all*
          Plugin Options ACL = *all*
      }
      ```
    - Redémarrez Bareos Director après avoir défini ce fichier :
      ```bash
      systemctl restart bareos-director
      ```

3. Quittez `bconsole` :
    ```plaintext
    *exit
    ```

#### **Méthode 2 : Activer un fichier de configuration existant**

1. Activez le fichier d'exemple :
    ```bash
    mv /etc/bareos/bareos-dir.d/console/admin.conf.example /etc/bareos/bareos-dir.d/console/admin.conf
    ```

2. Redémarrez Bareos Director pour appliquer la configuration :
    ```bash
    systemctl restart bareos-director
    ```

### 2.2. Vérifiez le profil `webui-admin`

1. Assurez-vous que le profil `webui-admin` est présent dans `/etc/bareos/bareos-dir.d/profile/webui-admin.conf` :
    ```plaintext
    Profile {
        Name = webui-admin
        CommandACL = !.bvfs_clear_cache, !.exit, !.sql, !configure, !create, !delete, !purge, !sqlquery, !umount, !unmount, *all*
        Job ACL = *all*
        Schedule ACL = *all*
        Catalog ACL = *all*
        Pool ACL = *all*
        Storage ACL = *all*
        Client ACL = *all*
        FileSet ACL = *all*
        Where ACL = *all*
        Plugin Options ACL = *all*
    }
    ```

2. Redémarrez Bareos Director pour appliquer les modifications :
    ```bash
    systemctl restart bareos-director
    ```

---

## 3. Accéder à Bareos WebUI

1. Ouvrez un navigateur et accédez à l'URL suivante :
    ```plaintext
    http://<adresse_IP_du_serveur>/bareos-webui
    ```

2. Connectez-vous avec les identifiants :
    - **Nom d'utilisateur** : `admin`
    - **Mot de passe** : celui défini dans `bconsole` ou dans le fichier de configuration.

---

## 4. Résolution des Problèmes

### 4.1. Vérifiez les journaux

En cas de problème, vérifiez les journaux pour diagnostiquer :

- Journaux Apache :
    ```bash
    tail -f /var/log/apache2/error.log
    ```
- Journaux Bareos Director :
    ```bash
    tail -f /var/log/bareos/bareos-dir.log
    ```

### 4.2. Vérifiez les permissions

Assurez-vous que les fichiers WebUI ont les permissions correctes :
    ```bash
    chown -R www-data:www-data /usr/share/bareos-webui
    chmod -R 755 /usr/share/bareos-webui
    ```

---

## 5. Notes supplémentaires

1. **Mises à jour WebUI** : Lors de la mise à jour vers Bareos 22 ou supérieur, assurez-vous que :
    - `mod-php` est désactivé ou supprimé.
    - `php-fpm` est correctement configuré et actif.

2. **Configurations avancées** :
    - Si Bareos WebUI est installé sur un autre système que Bareos Director, copiez les fichiers de configuration nécessaires.
    - Pour activer des plugins ou des fonctionnalités avancées, vérifiez les ACL dans les profils de Bareos Director.

Avec ces étapes, Bareos WebUI devrait être opérationnel et vous permettre de gérer vos sauvegardes via une interface graphique.

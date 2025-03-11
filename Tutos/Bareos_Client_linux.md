# Tutoriel : Configuration d'un Client Bareos sous Linux

Ce guide décrit les étapes pour configurer un client Bareos sur Debian (sans sudo) et sur Ubuntu (avec sudo). Assurez-vous que votre serveur Bareos est correctement configuré avant de commencer.

## Prérequis

- Un serveur Bareos opérationnel.
- Accès à une machine Debian ou Ubuntu pour installer le client.
- Accès root (pour Debian, vous êtes déjà connecté en tant que root ; pour Ubuntu, via `sudo`).
- Connaissances de base des commandes Linux.

---

## 1. Installation d'un client Bareos sur Debian (sans sudo)

### Étape 1 : Préparer le système
Avant d'ajouter le dépôt Bareos, assurez-vous que `gnupg` est installé :

```bash
apt install -y gnupg
```

### Étape 2 : Ajouter le dépôt Bareos
Téléchargez et exécutez le script pour ajouter les dépôts Bareos :

```bash
wget https://download.bareos.org/current/Debian_12/add_bareos_repositories.sh
chmod +x add_bareos_repositories.sh
./add_bareos_repositories.sh
apt update
```

### Étape 3 : Installer le client Bareos
Installez uniquement le démon de fichier Bareos :

```bash
apt install bareos-filedaemon
```

### Étape 4 : Configurer le client
1. Modifiez le fichier de configuration du démon de fichier :
   ```bash
   nano /etc/bareos/bareos-fd.d/director/bareos-dir.conf
   ```

2. Configurez le fichier pour permettre l'accès au Bareos Director :

   ```
   Director {
       Name = "bareos-dir"
       Password = "VOTRE_MOT_DE_PASSE"
       Description = "Permettre au Director configuré d'accéder à ce File Daemon."
   }
   ```

   Remplacez `VOTRE_MOT_DE_PASSE` par le mot de passe défini sur le serveur.

3. Redémarrez le service pour appliquer les modifications :
   ```bash
   systemctl restart bareos-fd
   ```

### Étape 5 : Vérifier le fonctionnement
Depuis le serveur Bareos, vérifiez que le client est joignable :

```bash
bconsole
*status client=nom_du_client-fd
```

---

## 2. Ajouter le client au serveur Bareos

### Méthode 1 : Utiliser `bconsole`

1. **Ouvrir `bconsole` :**
   ```bash
   bconsole
   ```

2. **Ajouter un client avec toutes les informations nécessaires :**
   ```bash
   *configure add client name=<nom_du_client-fd> address=<ip_ou_dns_du_client> password=<mot_de_passe> port=9102
   ```
   Exemple :
   ```bash
   *configure add client name=client1-fd address=192.168.1.100 password=mon_mot_de_passe port=9102
   ```

3. **Vérifier la configuration :**
   Après avoir ajouté le client, utilisez :
   ```bash
   *status client=<nom_du_client-fd>
   ```
   pour confirmer que le client est en ligne.

### Méthode 2 : Modifier les fichiers de configuration manuellement

#### Étape 1 : Modifier la configuration du Director
Sur le serveur Bareos, ajoutez les informations du client dans le fichier `/etc/bareos/bareos-dir.d/client/nom_du_client-fd.conf` :

```bash
nano /etc/bareos/bareos-dir.d/client/nom_du_client-fd.conf
```

Ajoutez ou modifiez la configuration suivante :

```
Client {
    Name = "nom_du_client-fd"
    Address = "IP_ou_nom_DNS_du_client"
    Password = "VOTRE_MOT_DE_PASSE"
    Catalog = MyCatalog
    FileRetention = 30 days
    JobRetention = 6 months
}
```

- **Name** : Le nom du client tel que configuré dans `bareos-fd.conf`.
- **Address** : L'adresse IP ou le nom DNS du client.
- **Password** : Le mot de passe doit correspondre à celui défini dans `bareos-dir.conf` côté client.

#### Étape 2 : Redémarrer le service Director
Après avoir enregistré les modifications, redémarrez le service Director :

```bash
systemctl restart bareos-dir
```

#### Étape 3 : Vérifier la connexion
Dans la console Bareos (`bconsole`), vérifiez l'état du client :

```bash
bconsole
*status client=nom_du_client-fd
```

Si le client est connecté correctement, vous devriez voir un message indiquant qu'il est en ligne.

---

## 3. Configuration des ports (Important)

Le port **9102** doit être ouvert **sur le client** pour permettre au serveur Bareos de se connecter au démon de fichier Bareos (File Daemon).

### Vérification des ports ouverts

#### Sur le client (port 9102) :
Assurez-vous que le port 9102 est ouvert :
```bash
netstat -tuln | grep 9102
```
Si le port n'apparaît pas, vérifiez que le service Bareos File Daemon est bien en cours d'exécution :
```bash
systemctl status bareos-fd
```

#### Sur le serveur (optionnel) :
Bien que le port 9102 ne soit pas requis côté serveur, assurez-vous que le pare-feu ou les règles réseau n'empêchent pas les connexions sortantes vers le client sur le port 9102.

### Ouvrir le port dans le pare-feu (si nécessaire)
Si vous utilisez `ufw` (pare-feu sous Debian/Ubuntu), ouvrez le port sur le client :
```bash
ufw allow 9102/tcp
```

---

## 4. Installation d'un client Bareos sur Ubuntu (avec sudo)

### Étape 1 : Préparer le système
Avant d'ajouter le dépôt Bareos, assurez-vous que `gnupg` est installé :

```bash
sudo apt update && sudo apt install -y gnupg
```

### Étape 2 : Ajouter le dépôt Bareos
Téléchargez et exécutez le script pour ajouter les dépôts Bareos :

```bash
wget https://download.bareos.com/bareos/release/latest/Ubuntu_$(lsb_release -sc)/add_bareos_repo.sh
chmod +x add_bareos_repo.sh
sudo ./add_bareos_repo.sh
```

### Étape 3 : Installer le client Bareos
Installez uniquement le démon de fichier Bareos :

```bash
sudo apt update && sudo apt install bareos-filedaemon
```

### Étape 4 : Configurer le client
1. Modifiez le fichier de configuration du démon de fichier :
   ```bash
   sudo nano /etc/bareos/bareos-fd.d/director/bareos-dir.conf
   ```

2. Configurez le fichier pour permettre l'accès au Bareos Director :

   ```
   Director {
       Name = "bareos-dir"
       Password = "VOTRE_MOT_DE_PASSE"
       Description = "Permettre au Director configuré d'accéder à ce File Daemon."
   }
   ```

   Remplacez `VOTRE_MOT_DE_PASSE` par le mot de passe défini sur le serveur.

3. Redémarrez le service pour appliquer les modifications :
   ```bash
   sudo systemctl restart bareos-fd
   ```

### Étape 5 : Vérifier le fonctionnement
Depuis le serveur Bareos, vérifiez que le client est joignable :

```bash
bconsole
*status client=nom_du_client-fd
```

---

## 5. Résolution des problèmes

### Vérifier le statut du service
- Debian :
  ```bash
  systemctl status bareos-fd
  ```
- Ubuntu :
  ```bash
  sudo systemctl status bareos-fd
  ```

### Tester la connexion
Vérifiez si le port 9102 est ouvert :
```bash
netstat -tuln | grep 9102
```

### Lancer le démon en mode debug
- Debian :
  ```bash
  /usr/sbin/bareos-fd -f -d 100
  ```
- Ubuntu :
  ```bash
  sudo /usr/sbin/bareos-fd -f -d 100
  ```

---

Une fois ces étapes terminées, votre client Bareos devrait être correctement configuré et opérationnel.

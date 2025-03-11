---
noteID: 4f005981-1db2-4174-ad59-15100763c025
---
Prérequis :
- 3 VM dans le même réseau interne :
	- 1 serveur Debian
	- 1 client Ubuntu
	- 1 client Windows 10

# 1. Configuration basique

## a. Debian Server

Installation et activation au démarrage :

```bash
apt update
apt install openssh-server
systemctl enable ssh
systemctl status ssh
```

Configuration du fichier `/etc/ssh/sshd_config`
```
PermitRootLogin yes
```
> Pas une bonne pratique, juste pour les tests
Relance service ssh avec `systemctl restart ssh`

Vérification du fichier `~/.ssh/known_hosts`
Test avec `ssh localhost`
2ème vérification du fichier `~/.ssh/known_hosts`


# b. Ubuntu

Installation d'openssh client :
```bash
sudo apt update
sudo apt install openssh-client
```

Test de connexion :
```bash
ssh root@<adresseIPServeurSSH> 
```

# c. Windows 10

Téléchargement et installation de Putty
Test de connexion en GUI

# 2. Durcissement de configuration

## a. Debian Server

Créer un compte de connexion ssh :
```bash
adduser wilder
```

Configuration du fichier de configuration  `/etc/ssh/sshd_config` :
- Faire une copie du fichier
- Opt. utiliser les fichier annexe avec **include**
	- En haut une ligne `Include /etc/ssh/sshd_config.d/*.conf`. Cette ligne va prendre en compte tous les fichiers ***.conf** du dossier **sshd_config.d** et les appliquer **avant** la configuration de ce fichier.
Pour un mot clé dans sa configuration, **sshd** ne prend en compte que la première valeur rencontrée. Comme le `Include` est présent en premier dans le fichier de configuration, c'est la configuration présente dans le dossier **sshd_config.d** qui a la priorité sur celle présente dans le fichier **sshd_config**.
=> Les fichiers de configuration annexes sont un bon moyen de personnaliser sa configuration sans modifier le fichier **sshd_config** d'origine.

Exemple :
- Dans `/etc/ssh/sshd_config` le port par défaut est **22**
- Dans un fichier de configuration sous `/etc/ssh/sshd_config.d/` le port par défaut est 2222.
Dans ce cas, le port par défaut sera 2222.

Dans un fichier `/etc/ssh/sshd_config.d/local.conf` (le nom **local** pourrait être différent, seul compte le **.conf** final) dont les droits correspondent à `-rw-r--r-- root root` ajoute les lignes suivantes :
* `Port 22`
* `AllowUsers wilder`

> ⚠️ **Attention** : La casse est importante dans les fichiers de configuration. Assure toi d'écrire les directives exactement comme elles sont supposées être, en respectant les majuscules et les minuscules.

Exemple :
Les termes `Port` ou `AllowUsers` doivent être écrit tel quel (respect de la casse)

Bonne pratique :
On ne se connecte jamais en root !
On ajoute donc la ligne `PermitRootLogin no`

```alert-info
# Note :
Un petit tour dans `man sshd_config` permet d'avoir plus d'information sur la configuration d'un serveur ssh
```

Configuration de `/etc/security/limits.conf` :
- Limitation du nombre de connexion avec le compte wilder :
	- Ajouter la ligne `wilder hard maxlogins 1`, pour limiter le nombre de connexion pour le compte wilder à 1 simultanément

Redémarrer le service ssh avec `systemctl restart sshd`

## b. Ubuntu et Windows 10

Test de connexion en root avec le port 2222
Test de connexion en wilder avec le port 2222

# 3. Utilisation clés de chiffrement

## a. Ubuntu

Générer une clé avec `ssh-keygen` :

```bash
wilder@CLIENT20:~$ ssh-keygen -t rsa -b 4096
Generating public/private rsa key pair.
Enter file in which to save the key (/home/wilder/.ssh/id_rsa): /home/wilder/.ssh/ubuntu_ssh
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/wilder/.ssh/debssh
Your public key has been saved in /home/wilder/.ssh/debssh.pub
The key fingerprint is:
SHA256:4ZasHbMNQSbD9Hg88gnD6jXVND86osf/9ddK2IylQnE wilder@CLIENT20
The key's randomart image is:
+---[RSA 4096]----+
|     o+ o o      |
|     ..O o o     |
|      * O o E    |
|     . X * + .   |
|    . o S +   .  |
|   . . B O . B   |
|    . o = o + = .|
|       . . . o .o|
|          ... ..o|
+----[SHA256]-----+

```

La commande ci-dessus créer 2 clés sous `/home/wilder/.ssh/` :
- **ubuntu_ssh.pub** : La clé publique
- **ubuntu_ssh** : La clé privée

> La commande `ssh-keygen` seule crée 2 clés **id_rsa** et **id_rsa.pub**.

On va copier la clé **publique** sur le serveur :

```bash
# ssh-copy-id <user>@<adresseIPServeurSSH>
ssh-copy-id -p 2222 -i ubuntu_ssh.pub wilder@<adresseServeur>
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "ubuntu_ssh.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
wilder@172.16.1.20's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh -p '2222' 'wilder@172.16.1.20'"
and check to make sure that only the key(s) you wanted were added.
```

Vérification sur le serveur -> la clé doit être dans le fichier `/home/wilder/.ssh/authorized_keys`

> Si le dossier `.ssh` ou le fichier `authorized_keys` n'existe pas, les créer.

## b. Windows 10

- Lancer le logiciel **Puttygen** qui est installé en même temps que Putty
- Sous `Parameter` choisir **RSA** et mettre **4096** pour `Number of bits in a generated key` et `Generate`
- Cliquer sur `Generate` et déplacer le curseur de la souris dans la fenêtre du générateur de clés PuTTY en tant que générateur aléatoire, afin de générer la clé privée
- On peut mettre une passphrase (optionnel)
- Sauvegarder les clés avec les boutons `Save public|private key`

On va copier la clé **publique** sur le serveur :

- Se connecter avec Putty sur le serveur
- Editer le fichier `/home/wilder/.ssh/authorized_keys` et coller le contenu de la clé publique dedans

Modification des paramètres dans Putty :
- Aller dans `Connection` -> `SSH` -> `Auth` -> `Credentials` et mettre l'emplacement de la clé privée
- Aller dans `Connection` -> `Data` et mettre le login à utiliser sur le serveur (ici `wilder`)


# 4. Configuration avancée

## a. Strict mode

Sur le serveur, dans le fichier `/etc/ssh/sshd_config` on peut ajouter le paramètre `StrictMode yes`.
Dans ce cas, il faut donner les bons droits au homedir sinon l’authentification risque d’échouer :

```bash
chmod go-w /home/wilder/
chmod 700 /home/wilder/.ssh
chmod 600 /home/wilder/.ssh/authorized_keys
```

Relancer le service ssh avec `systemctl restart ssh`.

## b. Connexion sans mot de passe

On peut ajouter `PasswordAuthentication no`  et `ChallengeResponseAuthentication no`
pour désactiver complètement l'accès avec mot de passe.
> Dans ce cas, bien garder la clé privé !

## c. Connexion sur de multiples serveur

On peut modifiez ou créer le fichier **~/.ssh/config** et l'adapter avec l’exemple ci-dessous :

```bash
Host serveur1
  HostName serveur1.domain.tld
  User wilder
  Port 22
  IdentityFile /home/remi/.ssh/id_rsa

Host serveur2
  HostName 192.168.1.120
  User wilder
  Port 22
  IdentityFile /home/remi/autre_cle/private_key
```

* **HostName** : Adresse ip ou nom de domaine du serveur
* **User** : Utilisateur à utiliser en login
* **Port** : Numéro du port à utiliser
* **IdentifyFile** : Chemin vers votre clé privée à utiliser

A partir de là, on peut se connecter au serveur directement avec `ssh serveur1`

## d. Connexion SSH à partir de l'hôte

Configurer la carte réseau de la VM serveur en **Réseau privé hôte** ou **Pont**.
C'est également possible en **NAT** mais il faut faire une redirection de ports.
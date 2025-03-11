
# **1. Définition**

**Root** est l'utilisateur qui a le plus de privilèges (droits) sur une machine Linux. L'utilisateur root a les autorisations maximales et peut faire n'importe quoi sur le système.

Root est fondamentalement l'équivalent de l’utilisateur **administrateur** sur Windows.
**su** et **sudo** sont utilisés pour obtenir les privilèges root.

Un utilisateur normal sur Linux n'est pas root, et fonctionne avec des autorisations réduites.
Il ne peut pas :

* Installer de logiciel
* Ecrire dans les répertoires système...

# **2. En tant que root**

Pour exécuter des commandes qui nécessite des privilèges élevés :

```shell
wilder@Ubuntu:~$ apt update
Lecture des listes de paquets... Fait
E: Impossible d'ouvrir le fichier verrou /var/lib/apt/lists/lock - open (13: Permission non accordée)
E: Impossible de verrouiller le répertoire /var/lib/apt/lists/
W: Problème de suppression du lien /var/cache/apt/pkgcache.bin - RemoveCaches (13: Permission non accordée)
W: Problème de suppression du lien /var/cache/apt/srcpkgcache.bin - RemoveCaches (13: Permission non accordée)
```

On utilise `sudo` :

```shell
wilder@Ubuntu:~$ sudo apt update
[sudo] Mot de passe de wilder : 
```

On met le mot de passe du 1er utilisateur (qui est dans le groupe) root.

Pour connaitre qui est dans le groupe root :

```bash
wilder@Ubuntu:~$ getent group root
root:x:0:
wilder@Ubuntu:~$ grep '^root:' /etc/group
root:x:0:
```

**sudo** ne va exécuter qu'une seule commande en root.
Si on a plusieurs commandes, il faudra mettre `sudo` à chaque fois.

```shell
sudo apt update && sudo apt upgrade
```

# **3. Avoir un shell en root (sans activer root)**

## a. Méthode sudo su

```shell
wilder@Ubuntu:~$ sudo su
[sudo] Mot de passe de wilder : 
root@Ubuntu:/home/wilder# 
```

> On est en root dans le /home de l'utilisateur

Le caractère `#` après le prompt indique que l'on est en root.

## b. Méthode sudo -i

```shell
wilder@Ubuntu:~$ sudo -i
[sudo] Mot de passe de wilder : 
root@Ubuntu:~# 
```

> On est en root dans le répertoire personnel de root, soit /root

> Dans les 2 méthodes on utilise le mot de passe du compte utilisateur.
> Pour rappel, il n'est pas recommandé d'avoir un shell complet en root !
> Avec ce système, il n'y a toujours qu'un seul mot de passe : celui de l'utilisateur.


# **4. Avoir un shell en root avec su**

```bash
wilder@Ubuntu:~$ su
Mot de passe : 

su: Échec de l’authentification

```

Impossible sur Ubuntu avec un compte root non-activé

# **5. Initialiser le compte root**

Par défaut, le compte **root** n'a pas de mot de passe et n'est pas activé sur Ubuntu.

> Sur Debian, le  compte root est initialisé à l'installation

**Ubuntu ne recommande pas d'activer ce compte**.

On utilise la commande `passwd` qui permet de changer le mot de passe d'un utilisateur, et donc ici d'initialiser le mot de passe de **root**.

```shell
sudo passwd root
```

Exemple :

```shell
wilder@Ubuntu:~$ sudo passwd root
[sudo] Mot de passe de wilder : 
Nouveau mot de passe : 
Retapez le nouveau mot de passe : 
passwd : le mot de passe a été mis à jour avec succès
wilder@Ubuntu:~$ 
```

# **6. Avoir un shell en root avec su (avec un compte root activé)**

Une fois le compte root activé :

```shell
wilder@Ubuntu:~$ su
Mot de passe : 
root@Ubuntu:/home/wilder# 
```

# **7. Exécution d'une commande avec su (avec un compte root activé)**

De même on peut exécuter une commande en tant que root :

```shell
wilder@Ubuntu:~$ su -c "apt-get update"
```


**Su** bascule sur le compte d'utilisateur **root** et donc requière le mot de passe de root.

# **8. Les comptes d'administration sur les distribution Linux**

Sur Linux, la commande **su** est le moyen traditionnel pour avoir les autorisations **root**.
La commande **sudo** existe depuis longtemps, mais Ubuntu a été la première distribution Linux populaire à devenir sudo uniquement par défaut.

A l'installation d'Ubuntu, le compte root standard est créé, mais ***aucun mot de passe ne lui est attribué***.
On ne peut pas se connecter en tant que root tant que l'on n'a pas attribué un mot de passe au compte root.

**Avantages à l'utilisation de sudo au lieu de su** :

* Sur Ubuntu il n'y a qu'un seul mot de passe à retenir alors que sur les autres distribution il faut un mot de passe pour l'utilisateur et pour root.
* Sur Ubuntu, cela évite d'avoir un **shell root** d'ouvert pour des tâches non-administratives, donc d’exécuter moins de commandes en root qui ne demandent pas autant de privilèges.

# **9. Exemple avec un nouvel utilisateur**

## a. Création d'un utilisateur

```bash
wilder@Ubuntu:~$  sudo adduser toto
Ajout de l'utilisateur « toto » ...
Ajout du nouveau groupe « toto » (1001) ...
Ajout du nouvel utilisateur « toto » (1001) avec le groupe « toto » ...
Création du répertoire personnel « /home/toto »...
Copie des fichiers depuis « /etc/skel »...
Nouveau mot de passe : 
Retapez le nouveau mot de passe : 
passwd : le mot de passe a été mis à jour avec succès
Modification des informations relatives à l'utilisateur toto
Entrez la nouvelle valeur ou « Entrée » pour conserver la valeur proposée
	Nom complet []: 
	N° de bureau []: 
	Téléphone professionnel []: 
	Téléphone personnel []: 
	Autre []: 
Ces informations sont-elles correctes ? [O/n] o
```

Ici on a crée un utilisateur `toto`.

## b. Vérification création

Afficher la liste des utilisateurs :

```shell
cat /etc/passwd | awk -F: '{print $1}' | grep -E 'wilder|toto'
```

Afficher la liste des groupes

```shell
cat /etc/group | awk -F: '{print $1}' | grep -E 'wilder|toto'
```

## c. Connection avec un autre utilisateur et test sudo

Ce nouvel utilisateur n'est pas dans le fichier **sudoers** donc **ne peut pas utiliser sudo**.

## d. Donner les droits d'utilisation sudo

### Méthode 1 : ajout au groupe sudo

```shell
sudo usermod -a -G sudo wilder
```

### Méthode 2 : ajout de l'utilisateur dans le fichier **/etc/sudoers**

* Editer le fichier :

```shell
sudo visudo
```

* Ajouter la ligne **wilder ALL = (ALL: ALL) ALL**
* Ecraser le fichier

## e. Vérification

Se connecter avec les autres comptes utilisateurs et vérifier que la commande sudo fonctionne correctement.
# 1. Représentation symbolique (rappel)

Avec `ls -l` sur un fichier :

```bash
-rwxr-xr-- 1 wilder wilder 0 mars  14 15:53 file.txt
```

## a. Premier caractère

Indique le type de la cible

| d   | répertoire                           |
| --- | ------------------------------------ |
| -   | fichier normal                       |
| l   | lien symbolique                      |
| s   | socket Unix                          |
| p   | tube nommé                           |
| c   | fichier de périphérique de caractère |
| b   | fichier de périphérique en mode bloc |

## b. Suite des caractères

| Droits d'accès | Signification         |
| -------------- | --------------------- |
| r              | Lecture (_read_)      |
| w              | Ecriture (_write_)    |
| x              | Exécution (_execute_) |
| -              | pas de droit          |


![[Pasted image 20240320185541.png]]

| Cible | Signification                     |
| ----- | --------------------------------- |
| u     | Utilisateur propriétaire (_user_) |
| g     | Groupe (_group_)                  |
| o     | Autres utilisateurs (_others_)    |

# 2. Représentation octale

| Droits d'accès | Valeur en octal |
| -------------- | --------------- |
| r              | 4               |
| w              | 2               |
| x              | 1               |

Pour convertir en octal, il suffit d’ajouter le(s) chiffre(s) correspondant à la (aux) lettres existantes.
Exemples :
- r w –    vaut  4 + 2 = 6
- r w x   vaut  4+ 2 + 1 = 7

| chiffre | droits |
| ------- | ------ |
| 0       | ---    |
| 1       | --x    |
| 2       | -w-    |
| 3       | -wx    |
| 4       | r--    |
| 5       | r-x    |
| 6       | rw-    |
| 7       | rwx    |

Avec `ls -l` sur un fichier :

```bash
-rwxr-xr-x 1 wilder wilder 0 mars  14 15:53 file.txt
```

![[Pasted image 20240320213817.png]]

> Cette méthode est souvent employée car plus rapide.

# 3. Commande chmod

## a. Utilité

La commande **chmod** sert à attribuer des droits d'accès dans les systèmes de fichiers.
Agit sur :
- Propriétaire (**user**)
- Groupe (**group**)
- Autres utilisateurs (**other**)

Méthode :
- Symbolique
- Octale

## b. Modification des droits avec la méthode symbolique

### i. Syntaxe

```bash
chmod <cible> <opérateur> <droit> fichier/dossier
```

| Cible | Signification                     |
| ----- | --------------------------------- |
| u     | Utilisateur propriétaire (_user_) |
| g     | Groupe (_group_)                  |
| o     | Autres utilisateurs (_others_)    |
| a     | Tout le monde (_all_)             |

| Opérateurs | Signification         |
| ---------- | --------------------- |
| +          | ajout de droits       |
| -          | suppression de droits |
| =          | droits implicites     |

| Droits d'accès | Signification         |
| -------------- | --------------------- |
| r              | Lecture (_read_)      |
| w              | Ecriture (_write_)    |
| x              | Exécution (_execute_) |
| -              | pas de droit          |

### ii. Exemples

- Ajouter pour tout les autres le droit d’écriture et exécution pour le fichier **file.sh**
```shell
chmod o+wx file.sh
```
- Supprimer pour tout le monde le droit d'écriture et d’exécution du fichier **file.sh** :
```shell
chmod a-wx file.sh
ou
chmod -wx file.sh
```
- Droits en lecture écriture au groupe et lecture pour les autres pour le fichier **file.sh** :
```bash
chmod g+rw,o+r file.sh
```
- Droits en lecture écriture exécution pour l'utilisateur (propriétaire) sur l'arborescence du dossier **myDocuments** :
```bash
chmod -R u+rwx myDocuments
```
- Donner le droit de lecture pour le groupe et les autres pour le fichier **file.sh** :
```bash
chmod g=r,o=r file.sh
```

## c. Modification des droits avec la méthode octale

### i. Syntaxe

```bash
chmod <nombre octal>
```

| chiffre | droits |
| ------- | ------ |
| 0       | ---    |
| 1       | --x    |
| 2       | -w-    |
| 3       | -wx    |
| 4       | r--    |
| 5       | r-x    |
| 6       | rw-    |
| 7       | rwx    |

### ii. Exemples

- Droits total pour l'utilisateur (propriétaire), et lecture écriture pour le groupe et les autres pour le fichier **file.sh** :
```bash
chmod 766 file.sh
```
- Droits lecture écriture pour l'utilisateur (propriétaire), et lecture pour le groupe pour le fichier **file.sh** :
```bash
chmod 640 file.sh
```
- Droits total pour l'utilisateur (propriétaire), lecture écriture pour le groupe, et juste lecture pour les autres pour l'arborescence sous le dossier **myDocuments** :
```bash
chmod -R 764 myDocuments
```

# 4. Lister les fichiers du systèmes avec des droits spécifiques (BONUS)

Exemple : Lister les fichiers dont les utilisateurs "autres" ont les droits rwx dans le `/home` d'un utilisateur.
> Normalement il n'y a personne !

```bash
find /home/wilder/ -type f -perm -o=rwx -exec ls -l {} \;
```
ou
```bash
find /home/wilder/ -type f -perm -667 -exec ls -l {} \;
```

Explication :
- `find /home/wilder/` : Utilisation de la commande **find** sous `/home/wilder/` (avec les sous-répertoires)
- `-type f` : Ne cherche que les fichiers (donc pas les répertoires)
	- Uniquement les répertoires : `-type d`
	- Les fichiers et les répertoires : `\( -type f -o -type d \)`
- `-perm` : Recherche basée sur les droits
	- `-o=rwx` : droits **rwx** pour **o**ther en représentation symbolique
	- `-o=667` : droits **rwx** pour **o**ther en représentation octale
- `-exec ls -l {} \;` : Exécute `ls -l` sur chaque fichier trouvé
	- `{}` : Représente chaque fichier trouvé
	- `\;` : Fin de la commande `-exec`
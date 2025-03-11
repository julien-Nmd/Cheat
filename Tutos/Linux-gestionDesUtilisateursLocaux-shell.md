Démo suite cours :
* La gestion des utilisateurs

# 1. Lister  

## a. Utilisateurs 

```bash
cat /etc/passwd | awk -F: '{print $1}' 
```

## b. Groupes

```bash
cat /etc/group | awk -F: '{print $1}' 
``` 

# 2. Gestion cat utilisateur 

## a. Commande adduser 

Création dossiers, répertoires, arborescence, … 
Création de compte automatiquement avec tous les dossiers 

```bash
sudo adduser toto1
```

> Vérifier avec `ls -la /home/toto1 `

## b. Commande useradd 

Création du **compte seul** (sans création automatique des répertoires).
 
```
sudo useradd toto2
```
 
> sans option ==> utilisation des paramètres dans **/etc/default/useradd**

==> création d'une entrée dans : 

- `/etc/passwd` : Base de données textuelle des utilisateurs
- `/etc/shadow` : Gestion des mots de passe
- `/etc/group` : Groupes des utilisateurs
- `/etc/gshadow` : Groupes secondaires et leurs mots de passe

| Option      | Description                                                                                                                                                        | Exemple                                     | Vérification                       | Actions supplémentaires                                                                                                                          |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------- | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **-m**      | Crée un répertoire personnel pour l'utilisateur. Dedans on a les fichiers de base (.bashrc, .profile, .bash_logout) qui viennent de /etc/skel/ (profil par défaut) | `sudo useradd -m -d /opt/wilder wilder`     | `ls -la /opt/wilder`               | Déplacer le /home : `sudo mv /opt/wilder /bin/wilder` puis `sudo usermod -d /bin/wilder wilder`. Vérification avec `sudo ls -la /bin/wilder`<br> |
| **-u 1500** | Spécifie un identifiant d'utilisateur unique (UID) pour l'utilisateur                                                                                              | `sudo useradd -u 1500 wilder`               | `id -u wilder`                     |                                                                                                                                                  |
| **-g**      | Spécifie un identifiant de groupe principal pour l'utilisateur                                                                                                     | `sudo useradd -g users wilder`              | `id -gn wilder`                    |                                                                                                                                                  |
| **-G**      | Ajoute l'utilisateur à des groupes supplémentaires multiples                                                                                                       | `sudo useradd -g users -G admin,dev wilder` | `id wilder`                        |                                                                                                                                                  |
| **-c**      | Ajoute un commentaire ou une description à l'utilisateur (champs GECOS)                                                                                            | `sudo useradd -c "utilisateur test" wilder` | `grep wilder /etc/passwd`          |                                                                                                                                                  |
| **-e**      | Définit une date d'expiration pour l'utilisateur                                                                                                                   | `sudo useradd -e 2022-12-22 wilder`         | `sudo chage -l wilder`             |                                                                                                                                                  |
| **-s**      | Spécifie le shell par défaut pour l'utilisateur                                                                                                                    | `sudo useradd -s /usr/bin/zsh wilder`       | `grep wilder /etc/passwd`          |                                                                                                                                                  |
| **-D**      | Modifie les options par défaut pour la commande `useradd`                                                                                                          | `sudo useradd -D -s /bin/bash`              | `sudo useradd -D \| grep -i shell` |                                                                                                                                                  |

## c. Mot de passe 

On doit créer le mot de passe pour pouvoir se connecter : 
`sudo passwd <user>`
==> modification du mot de passe d'un autre utilisateur 

## d. Ajout chaîne dans /etc/passwd 

```bash
echo "user1:x:2000:2000:user1:/home/user1:/bin/bash" | sudo tee -a /etc/passwd > /dev/null
```

## e. Commande userdel 

Userdel --> Suppression compte seul (pas les groupes, …) 
`sudo userdel -r toto`
## f. Commande deluser 

```bash
# Suppression complète 
sudo deluser toto
# Suppression du home directory (qui est conservé)
sudo rm -r /home/utilisateur
```

=> Donc 
Gestion complète automatisée :
- `adduser`
- `delluser`
Gestion manuelle (script) :
- `useradd`
- `userdel`

## g. Modification

Même paramètres que useradd  :

* **-d** répertoire utilisateur 
* **-g** définit le GID principal 
* **-l** identifiant utilisateur 
* **-u** UID utilisateur 
* **-s** shell par défaut 
* **-G** ajoute l’utilisateur à des groupes secondaires 
* **-m** déplace le contenu du répertoire personnel vers le nouvel emplacement 

```bash
# changement du répertoire personnel et ajout de l'utilisateur toto3 à un groupe secondaire.
usermod -d /home/toto3 -a -G toto3 toto3
```

# 3. Gestion de groupe  

## a. Création de groupe 

`sudo groupadd nomgroupe`

## b. Ajout à un groupe (adduser et usermod) 

```shell
sudo adduser toto nomGroupe 
sudo usermod -a -G nomGroupetoto 

sudo gpasswd -a toto nomGroupe 
sudo gpasswd --add nom-utilisateur nom-groupe 

#Exemple sur Debian pour mettre l'utilisateur toto dans le groupe sudo
sudo usermod -aG sudo toto
# Verif
groups toto
# Verif par commande
sudo ls /root
```

## c. Retrait d'un groupe 

```shell
sudo deluser toto nomGroupe 
sudo gpasswd --delete nom-utilisateur nom-groupe 
```

## d. Suppression d'un groupe

```bash
sudo groupedel nomDuGroupe
```

# 4. Verrouillage

## a. Verrouillage d'un compte

```bash
sudo usermod --expiredate 1 toto
```
Vérification :
```bash
sudo chage -l toto
```

## b. Réactivation du compte
```bash
sudo usermod --expiredate "" toto
```

# 5. Gestion des utilisateurs à distance (BONUS)

> Prérequis : avoir un serveur accessible en SSH
## a. SSH

```bash
ssh user@ip_address
scp <fichier à envoyer> user@ip_address:<emplacement distant>
```

## b. Exécuter de commandes à distance

```bash
# Lister les utilisateurs sur une machine distante
ssh admin@192.168.1.10 "cat /etc/passwd | awk -F: '{print \$1}'"
```

```bash
# Création d'un utilisateur à distance
ssh admin@192.168.1.10 "sudo useradd -m -s /bin/bash toto10"
```

```bash
# Définition du mot de passe (interaction avec le terminal distant)
ssh admin@192.168.1.10 "sudo passwd demoUser"
```

```bash
# Copie d'un script sur une machine distante
scp create_user.sh admin@192.168.1.10:/home/admin/
# Connexion et exécution du script
ssh admin@192.168.1.10 "bash /home/admin/create_user.sh demoUser"
```


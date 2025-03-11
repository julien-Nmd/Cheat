Démo suite cours :
* Git/Github

# 1. Création de clés SSH

## a. Sur Windows

### i. Avec gitbash ou mobaxterm

- Exécuter la commande :
```bash
# Adresse mail en lien avec le compte Github
ssh-keygen -t ed25519 -C "mom_adresse_email@example.com"
```
> Si c'est la première clé SSH, elle doit s'appeler id_...
- Ajout de la clé **privée** à l'agent SSH
```bash
ssh-add id_ed25519
```
> Si erreur avec l'agent SSH :
> - Vérification avec la commande `echo $SSH_AUTH_SOCK`
> - si vide -> eval $(ssh-agent -s)
> - Revérifier avec la commande `echo`
> - Refaire `ssh-add ...`

Pour garder la configuration au prochain démarrage :
- Créer un fichier `~/.bashrc`
- L'editer
- Ajouter les lignes :
```bash
eval $(ssh-agent -s)
# Emplacement de la clé privée
ssh-add /c/Temp/id_ed25519
```
- Recharger le fichier avec `source ~/.bashrc`

Pour avoir le contenu de la clé publique :
```bash
# affichage du contenu de la clé publique avec cat
# Attention, le nom de la clé publique peut changer !
cat id_ed25519.pub
```

### ii. En PowerShell

```powershell
ssh-keygen -t ed25519 -C "mon_adresse_email@example.com"
```

## b. Sur Linux

En shell :
```bash
ssh-keygen -t ed25519 -C "mon_adresse_email@example.com"
cat ~/.ssh/id_rsa.pub
```

# 2. Gestion des clés SSH

## a. Envoie sur Github

- Sur internet, dans le compte Github, aller dans "Settings" ->  "SSH and GPG keys" -> "New SSH key"
- Donner un titre significatif, et coller le contenu de la clé publique dans le champ "Key", cliquer sur "Add SSH key"

## b. Test de la connexion à Github

```bash
ssh -T git@github.com
```

Si la configuration est ok => message de bienvenue de GitHub.

# 3. Création de dépôt

## a. Méthode 1 : À partir d'un dépôt local

- Création d'un dépôt en local :
```bash
# Initialisation
git init
# Renommer la branche (si necessaire)
git branch -m master main
# Ajout des fichiers au dépot (local)
git add .
# Commit
git commit -m "First commit"
```
- Gestion des identifiants :
```bash
git config --global user.email "mom_adresse_email@example.com"
git config --global user.name "mon nom"
```
- Création d'un dépôt vide sur Github **monDepotGithub1**
- Liaison :
```bash
git remote -v
# git remote add origin <url SSH>
git remote add origin git@github.com:username/monDepotGithub1.git
# Vérification
git remote -v
```
- Envoie des changements locaux vers Github :
```bash
git push --set-upstream origin main
git push -u origin main
```

## b. Méthode 2 : À partir d'un dépôt Github

- Création dépôt Github **monDepotGithub2**
- Pour avoir accès au dépôt de mon profil, sur le dépôt :
	- `Edit Pins` pour accrocher le nom du dépôt sur ma page d'accueil
	- `Star` pour mettre le dépôt de favoris
- Clone du dépôt distant en local :
```bash
# clonage du dépot distant
# Attention à ne pas être dans un deôt local git !
git clone <url SSH>
# Exemple
git clone git@github.com:username/monDepotGithub2.git
```
- Ajout des fichiers au dépôt (local) et commit
```bash
git add .
git commit -m "update"
```
- Envoie des changements locaux vers Github :
```bash
git push -u origin main
#OU git push
```

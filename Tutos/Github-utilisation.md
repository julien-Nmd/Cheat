
Démo suite cours :
* Git/Github

# 1. Création de branche et bascule sur cette branche

* `git checkout -b test` => option `-b` créer et bascule sur la branche :
```bash
# Création d'une nouvelle branche et bascule sur celle-ci :
git checkout -b nouvelle_branche
```
- Modifications, commit, et envoie :
```bash
git add .
git commit -m "Modifications sur branche test"
git push origin test 
```
- Bascule entre les branches
```bash
git checkout main
git checkout nouvelle_branche
```

> Faire des modifications sur la branche locale et voir les effets sur github (avec git push)

> Montrer les différence de contenu du dépôt local suivant la branche sélectionnée avec `git checkout nomBranche`

# 2. MAJ du depot local à partir de Github

## a. Commande git pull

`git pull origin main` ou `git pull origin test` (si une branche test existe sur github)
```bash
git pull origin main
```

> Peut amener des problèmes de conflit

## b. Commande git fetch

=> Récupère les dernières modifications des branches du dépôt distant dans le dépôt local
Après avoir effectué la récupération, on peut inspecter les modifications avec des commandes telles que `git log` ou `git diff` pour voir ce qui a changé.
On peut ensuite fusionner ces modifications dans les branches locales à l'aide de `git merge` ou `git rebase`  selon les besoins.
 - Avec `git fetch` :
```bash
git fetch origin
```
- Avec `git log` ou `git diff` :
```bash
git log
git diff
```

## c. Conflit de version

Exemple après un `git pull` qui amène une erreur (modification sur dépôt github différentes du dépôt local)

```bash
# sauvegarde des modifications locales
git stash

# pull du depot distant
git pull origin nom_branche

# application des modifications "stashed"
git stash apply
```

* dans un fichier "stashed" :

```
<<<<<<< Updated upstream
Hello
=======
world !
>>>>>>> Stashed changes

```

* résoudre les conflits et :

```bash
git add fichier_conflituel
git commit -m "Conflit résolu"
git push origin nom_branche
```


# 3. Fichier .gitignore

* à la racine du dépôt
* wildcards possible
* Ne pas oublier de commiter le fichier !
* Exemple :
```bash
# Ignorer tous les fichiers .log
*.log
# Ignorer le dossier node_modules
node_modules/
```

# 4. Fusion de branche

```bash
# Bascule sur la branche main
git checkout main
# Récupére les dernièers modifs sur la branche main sur le dépôt distant "Origin"
git pull origin main
# Fusionne les modifs de la branche "nom_branche" dans la branche active (main)
git merge nom_branche
```

En cas de conflits, résoudre, ajouter, commiter, et faire un `push` :
```bash
git add fichier_conflituel
git commit -m "Conflit résolu"
git push origin main
```

# 5. Annexe - Les commandes

- **git init**: Démarrer un nouveau projet
  - exemple : `git init`

- **git add**: Après avoir créé/modifié un fichier
  - exemple : `git add fichier.txt` ou `git add .`

- **git commit**: Après `git add`
  - exemple : `git commit -m "Update content"`

- **git status**: Vérification des changements
  - exemple : `git status`

- **git branch**: Créer une nouvelle branche
  - exemple : `git branch nouvelle_branche`

- **git checkout**: Passer à une autre branche
  - exemple : `git checkout nom_branche`

- **git push**: Après un commit
  - exemple : `git push origin main` ou `git push`

- **git pull**: Mettre à jour le dépôt local
  - exemple : `git pull origin main` ou `git pull`

- **git merge**: Fusionner une branche dans `main`
  - exemple : `git merge nom_branche`

- **git clone**: Obtenir un projet existant
  - exemple : `git clone url_du_repo` (attention : URL SSH)

- **git remote**: Ajouter un dépôt distant
  - exemple : `git remote add origin url_du_repo`

- **git log**: Voir les modifications précédentes
  - exemple : `git log`

- **git diff**: Avant un `git add`
  - exemple : `git diff`

- **git stash**: Sauvegarder des changements sans commit
  - exemple : `git stash`

- **git reset**: Annuler un commit
  - exemple : `git reset HEAD~1`

- **git revert**: Annuler une modification publiée (et annule un commit)
  - exemple : `git revert commit_hash`

- **git config**: Définir l'utilisateur et l'email
  - exemple : `git config --global user.name "Nom"`

- **git fetch**: Mise à jour sans fusion
  - exemple : `git fetch origin`

- **git branch**: voir sur quelle branche on est
  - exemple : `git branch`
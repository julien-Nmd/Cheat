
# 1. Introduction

## a. Sur quels système ?

`history` est une commande intégrée à Bash
=> Permet de suivre et de gérer les commandes exécutées précédemment dans un terminal.
=> Disponible par défaut sur Ubuntu et Debian.
Fichier d'historique : `~/.bash_history`

## b. Fonctionnement

- Affiche la liste numérotée des commandes saisies précédemment
- Chaque commande est précédée de son numéro dans l’historique
- Une commande répétée n’apparaît qu'une seule fois dans l'historique :
	- `ignoredups` : empêche les commandes répétées d'apparaître plusieurs fois dans l'historique
	- `ignorespace` : ignore les commandes qui commencent par un espace dans l'historique
	- `ignoreboth` : Les 2 options ci-dessus

# 2. Utilisation

Commande de base : `history`.
- `history [n]` : Affiche les `n` dernières commandes
	- Ex. : `history 10` -> affiche les 10 dernières commandes
- `!n` : Exécute la commande numéro `n` dans l'historique
	- Ex. : `!50` -> exécute la commande numérotée 50
- `!<texte>` : Exécute la dernière commande commençant par `<texte>`
	- Ex. : `!ls` -> exécute la dernière commande qui commence par `ls`
- `Ctrl + r` -> pour rechercher une commande en tapant un motif partiel

# 3. Stockage et persistance de l'historique

Historique dans fichier `~/.bash_history`.
Modification de la longueur de l'historique enregistrée, dans `~/.bashrc` :
- Nombre de commandes enregistrées :
	- Variable `HISTSIZE` : Définit le nombre maximum de commandes à retenir dans l'historique de la session en cours
	- Variable `HISTFILESIZE` : Définit le nombre maximum de commandes à stocker dans le fichier `.bash_history`
  - Modifier ces valeurs dans le fichier `.bashrc` :
```bash
# Par défaut
HISTSIZE=1000
HISTFILESIZE=2000
```

# 4. Synchronisation de l'historique entre plusieurs terminaux

Par défaut, l'historique n’est pas synchronisé entre plusieurs sessions de terminal ouvertes simultanément.
Chaque terminal enregistre son propre historique local jusqu'à la fermeture.

`history -a` : Ajoute les commandes de la session en cours dans le fichier d'historique sans attendre la fermeture du terminal.
`history -r` : Relit et charge dans l’historique les commandes enregistrées par d’autres sessions de terminal.

> Pratique : Utiliser `history -a` dans chaque terminaux ouvert pour MAJ l’historique commun.

# 5. Suppression et gestion de l'historique

- Effacer l’historique de la session actuelle : `history -c` -> Efface uniquement l'historique de la session en cours.
- Supprimer une entrée spécifique : `history -d <numéro>` -> Supprime la commande à la position `<numéro>`.
	- Ex. : `history -d 5` -> supprime la commande numéro 5
- Effacer l'historique global :
	- Supprimer le contenu du fichier `~/.bash_history`
		- => `cat /dev/null > ~/.bash_history`






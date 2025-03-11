Dans le cours : `Objectif : fournir l'accès au même fichier depuis différents répertoires`

# 1. Lien symbolique (ou symlink)

* Alias du fichier original
* Pointeur vers un autre fichier ou répertoire

## a. Création

```bash
mkdir Documents/test
echo "contenu fichier original symlink" > Documents/test/fileOri.txt
ln -s Documents/test/ dossierTest_symLink
ln -s Documents/test/fileOri.txt fichierTest_symLink.txt
```

=> contenu dans un fichier = contenu dans l'autre fichier

## b. Vérification

Avec `ls -l` => caractère `l` au début des permissions
Avec `ls -la` => Donne les cibles
Vrai fichier/dossier => utiliser la commande `readlink -f <nomDuLienSymbolique>`

## c. Modification

```bash
echo "ajout de contenu dans fichier original" >> Documents/test/fileOri.txt
cat fichierTest_symLink.txt

echo "ajout de contenu dans fichier symlink" >> fichierTest_symLink.txt
cat Documents/test/fileOri.txt
```

=> modif dans un fichier = modif dans l'autre fichier

## d. Suppression

```bash
rm Documents/test/fileOri.txt
```

```bash
wilder@Ubuntu:~$ cat fichierTest_symLink.txt 
cat: fichierTest_symLink.txt: Aucun fichier ou dossier de ce type
```

**lien cassé**
=> suppression fichier original -> **impossible** d'avoir les données du fichier original


# 2. Hard link

* Nouvelle entrée dans la table d'index du système de fichiers
* Pointe vers les **même** blocs de données du disque
* Uniquement pour les fichiers (pas les dossiers)

Il n'y a pas 2 copies de données !!
## a. Création

```bash
echo "contenu fichier original hardlink" > Documents/test/fileOri.txt
ln Documents/test/fileOri.txt fichierTest_hardLink.txt
```

=> contenu dans un fichier = contenu dans l'autre fichier

## b. Modification

```bash
echo "ajout de contenu dans fichier original" >> Documents/test/fileOri.txt
cat fichierTest_hardLink.txt

echo "ajout de contenu dans fichier hard link" >> fichierTest_hardLink.txt
cat Documents/test/fileOri.txt
```

=> modif dans un fichier = modif dans l'autre fichier

## c. Suppression fichier original

```bash
rm Documents/test/fileOri.txt
cat fichierTest_hardLink.txt
```

=> suppression fichier original -> le fichier **hard link** reste intact et contient les données du fichier original

# 3. Cas d'utilisation

## a. Symlink

- Besoin de lier des fichiers ou des dossiers sur des systèmes de fichiers différents
- Besoin de liens flexibles qui peuvent pointer vers n'importe quel fichier ou dossier, même s'ils n'existent pas encore
- Besoin de créer des liens entre les fichiers dans des chemins d'accès différents
- Fonctionne sur des FS différents

## b. Hardlink

- Besoin de partager le même contenu entre plusieurs entrées de répertoire sans duplication de données sur le disque
- La suppression d'une entrée de répertoire ne supprime pas réellement les données, tant qu'il reste d'autres liens (hardlinks) pointant vers elles
* Besoin de liens entre les fichiers sur le même système de fichiers
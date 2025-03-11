Démo suite cours :
* La gestion du stockage

Pre-requis :
Avoir une VM Linux avec un 2ème disque de 10 Go

# 1. Trouver le nom du disque

```bash
lsblk
fdisk -l
```

# 2. Création de partitions

Créer 3 partitions avec `fdisk` :
	* /dev/sdb1 --> **ext4** (5 Go)
	* /dev/sdb2 --> **ext4** (3 Go)
	* /dev/sdb3 --> **swap** (espace disque restant)

```bash
sudo fdisk /dev/sdb
```

Puis :
- `n` pour une nouvelle partition
- `1` ou `2` ou `3` pour le numéro de partition
- Touche entrée pour le début du secteur
- `+5G` pour la taille (de la partition 1) (ou touche entrée pour la dernière partition)
- Modifier le type de la partition avec `t`
- Mettre `83` pour un type **ext4** et `82` pour un type **swap**
- `w` pour enregistrer et quitter

Pour supprimer complètement les signatures (et les partitions) sur un disque : 
```bash
sudo wipefs -a /dev/sdb
```
> À ne pas faire sinon tout est perdu !

# 3. Formatage

```bash
sudo mkfs.ext4 -L DATA /dev/sdb1
sudo mkfs.ext4 -L DOSSIER_PERSO /dev/sdb2
sudo mkswap /dev/sdb3
```

Pour vérifier les labels :
```bash
lsblk -o NAME,LABEL
```
Activation du swap :
```bash
sudo swapon /dev/sdb3
```

> Pas besoin formater ni de monter cette partition swap (et donc pas besoin de la démonter)

# 4. Partition /dev/sdb1
## a. Montage dans /mnt

```bash
sudo mkdir /mnt/data
sudo mount /dev/sdb1 /mnt/data
```

## b. Montage du dossier "Important" dans le /home

* Dans `/mnt/data`, créer 2 dossiers :
	* **Important** avec un fichier **fichier_important**
	* **confidentiel** avec un fichier **fichier_confidentiel**
- Créer un dossier `/home/wilder/Data_Perso`
- Monter le dossier **Important** dans `/home/wilder/Data_Perso` :

```bash
sudo mount --bind /mnt/data/Important /home/wilder/Data_Perso`
```

> `--bind` permet de monter un répertoire existant à plusieurs emplacements

# 5. Partition /dev/sdb2

```bash
cd ~
mkdir maPartition2
sudo mount /dev/sdb2 /home/wilder/maPartition2
```

Pb de droits :
```bash
sudo chown wilder:wilder /home/wilder/maPartition2
chmod 755 /home/wilder/maPartition2
```

# 6. Montage automatique au démarrage

Dans /etc/fstab :

```bash
/dev/sdb1  /mnt/data  ext4  defaults  0  0
/mnt/data/Important /home/wilder/Data_Perso none bind 0 0
/dev/sdb2 /home/wilder/maPartition2 ext4  defaults  0  0
/dev/sdb3  none  swap  sw  0  0
```

> Tester `/etc/fstab` avec `sudo mount -a` --> check erreurs avant de rebooter

# 7. Montage automatique au démarrage avec UUID de disque

Trouver l'UUID du disque avec la commande `sudo blkid`.
Dans /etc/fstab :

```bash
UUID="<uuid_de_sdb1>" /mnt/data  ext4  defaults  0  0
/mnt/data/Important /home/wilder/Data_Perso none bind 0 0
UUID="<uuid_de_sdb2>" /home/wilder/maPartition2 ext4  defaults  0  0
UUID="<uuid_de_sdb3>"  none  swap  sw  0  0
```

> Tester `/etc/fstab` avec `sudo mount -a` --> check erreurs avant de rebooter
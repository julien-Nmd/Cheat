# 1. Objectifs et matériel

## a. Objectifs

- Sauvegarde régulière de données automatiquement
- Possibilité de faire des sauvegardes manuelles
- Archivage

## b. Materiel/logiciel

- Ubuntu ou Windows
- NAS, disque dur externe, Cloud

# 2. Destination de stockage

## a. NAS

2x3 To en RAID 1

### i. Sur Ubuntu - Montage du NAS (méthode 1)

Dans le fichier `.bashrc` :

```shell
# Script pour le NAS au démarrage
bash /home/dom/perso/nasWD/NAS_montageLecteursAuto.sh
```

Script **NAS_montageLecteursAuto.sh** :

```shell
#/bin/bash

# --------------------- Init var ---------------------
nasIP="xxx.xxx.xxx.xxx"
# Partage sur le NAS
nasShare_perso="Dom_Personnel"
nasShare_wcs="WildCodeSchool"
nasShare_archives="Archives"
# Point de montage locaux
localMountPoint_perso="NAS_Perso"
localMountPoint_wcs="NAS_WildCodeSchool"
localMountPoint_archives="NAS_Archives"

# --------------------- Function ---------------------
mount_nas()
{
	# Montage du NAS
	local nasShare=$1
	local mountPoint=$2
	
	# Test existence point de montage
	if mountpoint -q "$mountPoint"
	then
		echo "Partage $nasShare déjà monté sur $mountPoint -> next action !"
	        return 0
        else
		# Création du dossier de point de montage s'il n'existe pas
        	if [ ! -d "$mountPoint" ]
        	then
        		mkdir -p "$mountPoint"
		fi
		# Montage du partage NAS
		sudo mount -t cifs "//${nasIP}/${nasShare}" "$mountPoint" -o username=xxx,password=xxx,uid=1000,gid=1000
		if [ ! $? -eq 0 ]
			then
			echo "Erreur -> montage de $nasShare sur $mountPoint KO"
		fi
	fi
}

# --------------------- Main ---------------------

# Test connectivité NAS
if ping -c 1 $nasIP &> /dev/null
then
	# Monter les partages
	mount_nas "$nasShare_perso" "/mnt/$localMountPoint_perso"
	mount_nas "$nasShare_wcs" "/mnt/$localMountPoint_wcs"
	mount_nas "$nasShare_archives" "/mnt/$localMountPoint_archives"
else
	echo "Connexion NAS KO"
fi
```

### ii. Sur Ubuntu - Montage du NAS (méthode 2)

Utilisation du fichier `/etc/fstab`
```bash
# NAS
//xxx.xxx.xxx.xxx/Dom_Personnel /mnt/NAS_Perso cifs username=xxx,password=xxx,uid=1000,gid=1000,iocharset=utf8,_netdev,nofail,user 0 0
//xxx.xxx.xxx.xxx/WildCodeSchool /mnt/NAS_WildCodeSchool cifs username=xxx,password=xxx,uid=1000,gid=1000,iocharset=utf8,_netdev,nofail,user 0 0
//xxx.xxx.xxx.xxx/Archives /mnt/NAS_Archives cifs username=xxx,password=xxx,uid=1000,gid=1000,iocharset=utf8,_netdev,nofail,user 0 0
```

### iii. Sur Windows 10

Lecteur mappé sur adresse IP du NAS en local.

## b. Disque dur externe

Définir :
- Taille
- Partition ext4 ou NTFS
- Type de données

## c. Cloud

Définir :
- Type de données
- Chiffrement ?
- Site ? Onedrive, Googledrive, Dropbox, ...=> selon besoin

# 3. Sauvegarde depuis PC Ubuntu

## a. Script shell vers NAS et hdd externe

```bash
#!/bin/bash

# Dominique Colleville
# Création : 01/08/2024
# MAJ : 20/12/2024
#   - 28/09/2024 : MAJ de dossier à synchroniser
#   - 20/12/2024 : Ajout choix d'export des VM virtualbox
# Version 1.3

check_dir()
{
    source_dir="$1"
    dest_dir="$2"

    if [ ! -d "$source_dir" ]
    then
        messDelete="Répertoire source $source_dir n'existe pas => IMPOSSIBLE de synchroniser avec répertoire de destination $dest_dir"
        echo "$messDelete"
        log "$messDelete"
        echo "yes"
    else
        echo "no"
    fi
}

create_dir()
{
    dir_path="$1"
    if [ ! -d "$dir_path" ]
    then
        if mkdir -p "$dir_path"
        then
            log "Répertoire créé: $dir_path"
        else
            log_error "Erreur de création du répertoire: $dir_path"
            exit 1
        fi
    fi
}

log()
{
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$logFile"
}

log_error()
{
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$errorLogFile"
}

menu_destination()
{
    local dialogTitle="Choix de la destination"
    local menuOptions=("[NAS]" "Disque dur NAS WD" \
                        "[HDD_SAVE2]" "Disque dur externe save2" \
                        "[HDD_WINLIN2]" "Disque dur externe WinLin2" \
                        "[Q]" "Quitter")
    local backTitle="Menu destination"

    if menuSelection=$(dialog --clear --backtitle "$backTitle" --title "$dialogTitle" --menu "Faire un choix:" 15 50 4 "${menuOptions[@]}" 3>&1 1>&2 2>&3)
    then
        echo "$menuSelection"
    else
        exit 1
    fi
}

menu_sauvegarde()
{
    local dialogTitle="Choix de la sauvegarde"
    local menuOptions=("[FULL]" "Sauvegarde COMPLETE (hors VM)" \
                "[WCS]" "Sauvegarde WCS (hors VM)" \
                "[PERSO]" "Sauvegarde perso (hors VM)" \
                "[VM]" "Sauvegarde VM Virtualbox" \
                #"[ARCH]" "Archivage (suppression prod)" \
                "[Q]" "Quitter")
    local backTitle="Menu Principal"

    if menuSelection=$(dialog --clear --backtitle "$backTitle" --title "$dialogTitle" --menu "Faire un choix:" 15 50 4 "${menuOptions[@]}" 3>&1 1>&2 2>&3)
    then
        echo "$menuSelection"
    else
        exit 1
    fi
}

display_message()
{
    echo "$1"
    log "$1"
}

sync_data()
{
    sourcePath="$1"
    destPath="$2"
    create_dir "$destPath"
    res=$(check_dir "$sourcePath" "$destPath")
    if [ "$res" = "no" ]
    then
        display_message "Synchro $sourcePath -> $destPath"
        rsync -auv --delete --info=progress2 "$sourcePath" "$destPath"
    fi
}

full_save()
{
    wcs_save "$1"
    perso_save "$1"
}

wcs_save()
{
    case $1 in
        "[NAS]" )
            local dest="$nasWCS"
            ;;
        "[HDD_SAVE2]" )
            local dest="$hdd1/WildCodeSchool"
            ;;
        "[HDD_WINLIN2]" )
            local dest="$hdd2/WildCodeSchool"
            ;;
    esac
    display_message "##################### WILD CODE SCHOOL => $1 ##########"
    display_message "###"
    sync_data "/home/$USER/Bureau/" "$dest/Bureau/"
    sync_data "/home/$USER/GNS3/projects/" "$dest/GNS3/projects/"
    display_message "###"
    sync_data "/home/$USER/Documents/0_A_trier/" "$dest/Documents/0_A_trier/"
}

perso_save()
{
    case $1 in
        "[NAS]" )
            local dest="$nasWCS"
            ;;
        "[HDD_SAVE2]" )
            local dest="$hdd1/perso"
            ;;
        "[HDD_WINLIN2]" )
            local dest="$hdd2/perso"
            ;;
    esac

    display_message "##################### PERSO => $1 #####################"
    sync_data "/home/$USER/Dropbox/" "$dest/Dropbox/"
    sync_data "/home/$USER/Images/" "$dest/Images/"
    sync_data "/home/$USER/perso/" "$dest/perso/"
}

vm_save()
{
    case $1 in
        "[NAS]" )
            local dest="$nasWCS/VirtualBoxExportVM"
            ;;
        "[HDD_SAVE2]" )
            local dest="$hdd1/VirtualBoxExportVM"
            ;;
        "[HDD_WINLIN2]" )
            local dest="$hdd2/VirtualBoxExportVM"
            ;;
    esac
    
    # Liste de toutes les VM
    mapfile -t vmList < <(vboxmanage list vms | awk -F'"' '{print $2}')
    echo "Liste des VM disponibles :"
    for i in "${!vmList[@]}"; do
        echo "$i) ${vmList[$i]}"
    done
    # Choix des VM à exporter
    read -p "numéros des VM à exporter (séparés par des espaces) : " -a selectedVmNumbers
    # Exporter les VM sélectionnées
    for num in "${selectedVmNumbers[@]}"
    do
        if [[ $num =~ ^[0-9]+$ ]] && [[ $num -ge 0 ]] && [[ $num -lt ${#vmList[@]} ]]
        then
            vm="${vmList[$num]}"
            echo "Exportation de la VM : $vm"
            if vboxmanage export "$vm" --output "$dest/$vm.ova"
            then
                echo "$vm -> OK"
            else
                echo "$vm -> NOK export"
            fi
        else
            echo "numéro invalide : $num"
        fi
    done
}

arch_save()
{
    local dest="$nasWCS"
}

start_script()
{
    display_message " "
    display_message "########## BEGIN SCRIPT ##########"
}

end_script()
{
    display_message "########## END SCRIPT ###########################"
}

##################### VAR ######################

scriptName=$(basename "$0")
logFile="$(dirname "$0")/${scriptName%.sh}.log"
errorLogFile="$(dirname "$0")/${scriptName%.sh}_error.log"

# Montage
nasWCS="/mnt/NAS_WildCodeSchool"
hdd1="/media/dom/save2"
hdd2="/media/dom/WinLin2"

##################### MAIN #####################

start_script
choixSauvegarde=$(menu_sauvegarde)
#echo $choixSauvegarde
#sleep 3
if [ "$choixSauvegarde" = "[Q]" ]
then
    end_script
    exit 0
else
    choixdestination=$(menu_destination)
    #echo $choixdestination
    #sleep 3
    if [ "$choixdestination" = "[Q]" ]
    then
        end_script
        exit 0
    else
        case $choixSauvegarde in
            "[FULL]" )
                full_save "$choixdestination"
                ;;
            "[WCS]" )
                wcs_save "$choixdestination"
                ;;
            "[PERSO]" )
                perso_save "$choixdestination"
                ;;
            "[VM]" )
                vm_save "$choixdestination"
                ;;
            "[ARCH]" )
                arch_save "$choixdestination"
                ;;
        esac
    fi
fi
end_script
exit 0
```

## b. Logiciel Obsidian

Utilisation des plugins :
- **Github Sync** => synchronisation avec repo Github
- **Remotely Save** => synchronisation avec dossier en cloud
Copie miroir sur NAS avec script de sauvegarde

## c. dépôt Github

Synchronisation dépôt github -> disque local
Copie miroir sur NAS avec script de sauvegarde

## d. Base de données sécurisée Keepass

Fichier de BDD sécurisée :
- Synchronisation avec un dossier local miroir d'un dossier cloud
Copie miroir sur NAS avec script de sauvegarde

Clé de chiffrement stockée sur autre cloud

# 4. Sauvegarde depuis PC Windows

# 5. Données personnelles - photos

Photos original (raw) => Sauvegarde sur NAS
Copie locale temporaire pour tri, modification, etc. -> sauvegarde su NAS dans dossier final




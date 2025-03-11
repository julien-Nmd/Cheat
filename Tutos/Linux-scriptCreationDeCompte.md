# 1. Interactif avec la commande read

```bash
#!/bin/bash

# Script création de compte

read -p "Donner un nom de compte à créer :" newUser

if cat /etc/passwd | grep $newUser
then
    # le compte $newUser existe
    # affichage message + sortie de script
    echo -e "Utilisateur $newUser existe\nSortie du script"
    exit 1
else
    #le compte $newUser n'existe pas
    # affichage message + création du compte
    echo "Création utilisateur $newUser"
    sudo useradd $newUser > /dev/null
    #verification création du compte
    if cat /etc/passwd | grep $newUser > /dev/null
    then
        #le compte $newUser existe ==> compte existant OK
        # ajouter des infos
        echo "Utilisateur $newUser crée !"
    else
        #le compte $newUser n'existe pas ==> message erreur"
        echo "Utilisateur $newUser non-crée ==> pb"
    fi
fi
exit 0
```

On peut remplacer 
```bash
sudo useradd $newUser > /dev/null
#verification création du compte
if cat /etc/passwd | grep $newUser > /dev/null
```
par
```bash
# Création du compte ET vérification en même temps
if sudo useradd $utilisateur
```

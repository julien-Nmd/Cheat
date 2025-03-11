
Interactif :

```bash
#!/bin/bash

# Script suppression de compte
read -p "Donner un nom de compte à supprimer :" delUser
if grep -w $delUser /etc/passwd > /dev/null 2>&1
then
    #le compte $delUser existe ==> suppression
    # message + suppression
    echo -e "Utilisateur $delUser déjà existant\nGo SUPPRESSION !"
    userdel -r -f $delUser 2> /dev/null
    #Vérification
    # option de grep :
    # -q : sortie silencieuse
    # -w : vérification de la chaine complète
    if cat /etc/passwd | awk -F: '{print $1}' | grep -wq "$delUser"
    then
        #le compte $delUser existe ==> erreur suppression
        # message
        echo "! Erreur : Utilisateur $delUser non-supprimé"
    else
        #le compte $delUser n'existe pas
        # message
        echo "Utilisateur $delUser supprimé"
    fi
else
    #le compte $delUser n'existe pas
    # message
    echo -e "Utilisateur $delUser non-existant\nSortie du script"
    exit
fi
exit 0
```

Avec menu et boucle :

```bash
#!/bin/bash

while true; do
  echo "Menu:"
  echo "1 - Supprimer un utilisateur"
  echo "2 - Quitter"
  read -p "Choisissez une option: " choice

  case $choice in
    1)
      read -p "Donner un nom de compte à supprimer: " delUser
      if grep -w $delUser /etc/passwd > /dev/null 2>&1
      then
	      echo -e "Utilisateur $delUser déjà existant\nGo SUPPRESSION !"
	      userdel -r -f $delUser 2> /dev/null
	      if cat /etc/passwd | awk -F: '{print $1}' | grep -wq "$delUser"
	      then
		      #le compte $delUser existe ==> erreur suppression
		      # message
		      echo "! Erreur : Utilisateur $delUser non-supprimé"
		  else
			  #le compte $delUser n'existe pas
			  # message
			  echo "Utilisateur $delUser supprimé"
		  fi
	  else
		  #le compte $delUser n'existe pas
	      # message
	      echo -e "Utilisateur $delUser non-existant"
      fi
      ;;
    2)
      echo "Sortie du script"
      exit 0
      ;;
    *)
      echo "Option invalide"
      ;;
  esac
done
exit 0
```

En prenant en compte le script d'ajout utilisateurs et en mettant des fonctions :

```bash
#!/bin/bash

function deleteUser()
{
	read -p "Donner un nom de compte à supprimer: " delUser
	if grep -w $delUser /etc/passwd > /dev/null 2>&1
	then
		echo -e "Utilisateur $delUser déjà existant\nGo SUPPRESSION !"
		userdel -r -f $delUser 2> /dev/null
		if cat /etc/passwd | awk -F: '{print $1}' | grep -wq "$delUser"
		then
			# le compte $delUser existe ==> erreur suppression
			# message
			echo "! Erreur : Utilisateur $delUser non-supprimé"
		else
			#le compte $delUser n'existe pas
			# message
			echo "Utilisateur $delUser supprimé"
		fi
	else
		#le compte $delUser n'existe pas
		# message
		echo -e "Utilisateur $delUser non-existant"
	fi
}

function addUser()
{
	read -p "Donner un nom de compte à créer: " newUser
	if grep -w $newUser /etc/passwd > /dev/null 2>&1
	then
		echo -e "Utilisateur $newUser déjà existant"
	else
		echo "Utilisateur $newUser non-existant ==> création"
		useradd $newUser
		if grep -w $newUser /etc/passwd > /dev/null 2>&1
		then
			echo "Utilisateur $newUser crée !"
		else
			echo "Utilisateur $newUser non-crée ==> pb"
		fi
	fi
}

while true; do
  echo "Menu:"
  echo "1) Supprimer un utilisateur"
  echo "2) Ajouter un utilisateur"
  echo "3) Quitter"
  read -p "Choisissez une option: " choice

  case $choice in
    1)
      deleteUser
      ;;
    2)
      addUser
      ;;
    3)
      echo "Sortie du script"
      exit 0
      ;;
    *)
      echo "Option invalide"
      ;;
  esac
done
exit 0
```


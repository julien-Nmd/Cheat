# 1. Gestion des OU

Création OU manuelle :
OU_Creation_manuelle.ps1

Création de plusieurs OU à partir d'une liste dans fichier : 
OU_Creation_auto.ps1
OU_Creation_auto.txt

Modification champs description d'une liste d'OU :
OU_Modification1.ps1
Exemple application :
`Get-ADOrganizationalUnit -Filter * -Properties Description | select DistinguishedName,Description | sort -Property DistinguishedName`
OU_Modification2.ps1

Suppression d'OU :
OU_Suppression_auto.ps1

# 2. Gestion des utilisateurs

Création d'utilisateurs :
USER_Creation_auto.ps1
USER_Creation_auto_Liste.txt

=> Debugage : recherche de doublons suite à une erreur
USER_Creation_auto_RechercheDoublons.ps1

USER_Creation_autoAleatoire.ps1

Suppression d'utilisateurs :
USER_Suppression_auto.ps1
USER_Suppression_auto.txt

DANGER => USER_Suppression_auto_AD.ps1

# 3. Gestion des ordinateurs

Création auto de PC :
COMPUTER_Creation_autoAleatoire.ps1

Rangement auto à partir du CN Computers :
COMPUTER_Rangement_auto.ps1

# 4. Gestion des groupes

Création de groupes à partir d'une liste :
GROUP_Creation_auto.ps1

Remplissage de groupe à partir des OU :
GROUP_Ajout_Utilisateurs_auto.ps1







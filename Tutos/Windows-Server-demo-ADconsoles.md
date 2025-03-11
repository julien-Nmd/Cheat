
Prérequis :
- VM Windows Server 2022 (Desktop) WINSERV1
	- Rôles AD-DS, DHCP, DNS
	- @IP 172.16.10.10/24
	- Domaine **Lab.lan**
	- Plage DHCP de 172.16.10.20 à 172.16.10.240
- - VM Windows Server 2022 (Core) WINSERV2
	- Rôles AD-DS (avec un compte Wilder10 du domaine)
	- @IP 172.16.10.11/24
- 2 VM client :
	- Client 1 @IP DHCP sur le domaine (avec un compte Wilder10 local)
	- Client 2 @IP DHCP hors domaine


# 1. Server Manager


- Détail du panneau latéral
- Détail des menus

# 2. Active Directory Users and Computers

- Détail des menus
- Explication hiérarchie
- Différence OU et conteneur
- Explication objet AD

# 3. Active Directory Administrative Center

Console + récente

Fonctionnalité avancée :
- Gestion des rôles et des attributs de schéma
- Gestion des stratégies de mot de passe fines
- Création et gestion des groupes gérés
- Gestion des objets d'annuaire connectés
- Gestion des domaines et forêts (nouvelles fonctionnalités de déploiement)

## a. Corbeille AD

Activation :
Active Directory Administrative Center -> `<Domain>` -> Tasks -> Enable Recycle Bin

Utilisation :
Active Directory Administrative Center -> `<Domain>` -> Deleted Objects

## b. Gestion fines des stratégies de mot de passe

Ajout dans le panneau latéral :
Active Directory Administrative Center -> Manage -> Add Navigation Nodes -> `<Domaine>` / System / Password Settings Container => Add th following ...

Utilisation :
Exemple Création d'une politique de mot de passe et attribution à un groupe utilisateur






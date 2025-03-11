# Installation


- Ce document explique comment installer Windows Server 2022, Windows 10, Ubuntu et Keepass. Certaines étapes sont décrites en détails, afin de couvrir la grande variété des petites particularités des différentes installations et configurations.

- Si vous avez des problèmes, prenez le temps d'étudier attentivement ces instructions : la plupart des difficultés y sont traitées. Si cela ne suffit pas, vous pouvez demander de l'aide à la communauté [Windows]( https://support.microsoft.com/fr-fr) ou [Linux](https://doc.ubuntu-fr.org/).

# Prérequis nécessaires

Pour le bon déroulement du projet, il vous faut :
- Un serveur installé en Windows Server 2022 ;
- Un client installé en Windows 10 ;
- Un client installé en Ubuntu (22.04 par exemple) ;
- Eventuellement l'hyperviseur VirtualBox ;
- Le logiciel d'installation Keepass.

## Matériel

Dans le cas d'une utilisation de machines virtuelles, les machines requises nécessitent des systèmes performants, répondant aux exigences minimales ci-dessous, afin de proposer une expérience d'utilisation agréable.

|         | Mémoire | Stockage | processeur        |
| ------- | ------- | -------- | ----------------- |
| Minimum | 8Go     | 50Go     | double coeur 2GHz |
| Idéal   | 16Go    | 1To      | i5 3.2GHz         |

- Espace disque : Votre disque dur ou votre SSD doit disposer de suffisamment de place pour accueillir ce nouveau système, chaque machine virtuelle occupant un certain espace – plusieurs giga-octets.
- Mémoire :16 Go (préférable), 8 Go (minimum) pour un fonctionnement sans heurt.

En plus des prérequis matériels et logiciels, vous devrez aussi réfléchir à la capacité de votre installation, pour lancer deux machines virtuelles ensemble voire trois.

## Logiciel

- Et, bien sûr, il faut installer sur le PC un logiciel de virtualisation, nous avons retenu le logiciel [VirtualBox](https://www.virtualbox.org/wiki/Downloads)  d'Oracle. Disponible gratuitement, en français, il se montre simple à mettre en place et à utiliser.
- Les images iso de [Windows 10](https://www.microsoft.com/fr-fr/software-download/windows10), [Windows server](https://www.microsoft.com/fr-fr/evalcenter/download-windows-server-2022) et [Ubuntu](https://www.ubuntu-fr.org/download/).
- Il nous faut également le logiciel [Keepass](https://keepass.info/download.html), indispensable pour chiffrer les mots de passe.


# Etapes d'installation et Configuration Serveur
## Configuration VM
- Créer une nouvelle machine virtuelle.
- La renommer **SRVWIN**, le nom que l'on donnera à notre machine lors de l'installation ;

	![vmname](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/cfae510c04c9086c0ad7a122a2b9b60daf664200/Install%20Server/vmname.png)

- Ne surtout **PAS** ajouter de CDRom d'installation à cette étape et laisser les paramètres de l'onglet "unattended install" par défaut ;
- Ajouter un total de **2 CPU** et minimum **2 Go de RAM** ;

 	![vmcpu](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/cfae510c04c9086c0ad7a122a2b9b60daf664200/Install%20Server/vmcpu.png)

- Configurer le stockage sur un minimum de **40 Go** ;

	![vmstock](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/cfae510c04c9086c0ad7a122a2b9b60daf664200/Install%20Server/vmstock.png)

- Valider puis aller dans la configuration de la machine virtuelle.
- Dans l'onglet Stockage, ajouter le .iso correspondant au CDRom d'installation de **Windows Server 2022** ;

	![vmcd](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/cfae510c04c9086c0ad7a122a2b9b60daf664200/Install%20Server/vmcd.png)

- Dans l'onglet Réseau, ajouter, en plus de l'adaptateur réseau NAT, un deuxième **adaptateur en Réseau interne**, connecté au *même réseau interne* que les futures VMs Clients.

	![vmnet](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/cfae510c04c9086c0ad7a122a2b9b60daf664200/Install%20Server/vmnet.png)

## Choix linguistiques

![TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/Install Server
/choixlangue.png](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/choixlangue.png)
- Langage d'installation : English (U.S.)
- Heure et devise : French (France)
	- Attention : il y a plusieurs French, bien choisir celui de la France ;
- Configuration clavier : French

## Lancer l'installation
- Sélection du système d'exploitation :

![[[Pasted image 20241009170739.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/choixos.png)

 - Sélectionner la version Standard avec Expérience utilisateur (*Standard Evaluation (Desktop Experience)* - en anglais) puis cliquer sur Next ;
	-  Nous ne sommes pas sur une configuration Datacenter et une interface graphique est préférable ;

- Cocher la case pour accepter les termes du contrat de licence puis cliquer sur Next ;

- Choisir le type d'installation : Custom

 ![[[Pasted image 20241009171918.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/typeinstall.png)

- Laisser la configuration par défaut et appuyer sur Next :

  ![[[Pasted image 20241009172105.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/configstock.png)
- Le système s'installe :

 ![[[Pasted image 20241009172140.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/install.png)
- Définition du mot de passe :
	- Le nom d'utilisateur est obligatoirement : Administrator
	- Définir le mot de passe par défaut : Azerty1*

## Configuration Serveur
- Découverte de réseaux : confirmer la découverte de la machine par les autres machines du réseau ;

 ![[[Pasted image 20241009174703.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/net.png)

- Installation des Guest Additions :
	- Dans l'onglet Périphériques de VirtualBox, insérer l'image CD des Additions invité ;

 ![[[Pasted image 20241009175000.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/addcd.png)

- Lancer VBoxWindowsAdditions.exe

![[Pasted image 20241009175136.png](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/vboxadd.png)](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/57c4446bdaa3aa201edbf339984b736ad6cf6eef/Install%20Server/vboxadd.png)

- Laisser toutes les configurations par défaut en appuyant sur Next jusqu'à l'installation des additions puis laisser le serveur redémarrer (Reboot now) avant de cliquer sur Finish ;

- Désactivation du Pare-feu
	- Après le redémarrage, se rendre dans l'onglet Local Server du Server Manager puis cliquer sur "Public : On, Private : On" :

 ![[[Pasted image 20241009175714.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/firewall.png)

 - Successivement sur les pages "Domain network", "Private network" et "Public network", entrer et désactiver les pare-feu en passant le bouton sur Off

  ![[[Pasted image 20241009180236.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/firedom.png)

 - Jusqu'à atteindre cet état sur les trois pare-feu :

![[[Pasted image 20241009180327.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/allfire.png)

- Activer la découverte de réseaux et le partage de fichiers :
	- Dans la barre de recherche windows, rechercher "Manage advanced sharing settings" ;
	- Pour chaque onglet "Private", "Guest or Public" et "All Networks", activer les boutons "Turn on network discovery" et "Turn on file and printer sharing" :

![[[Pasted image 20241009180655.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/share.png)

 - Puis cliquer sur "Save changes" ;

- Configuration de la carte réseau :
	- Avec la commande Windows+R, entrer "ncpa.cpl" pour ouvrir la modification des connecteurs réseaux :

  ![[[Pasted image 20241009181031.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/ncpa.png)

- Entrer dans les propriétés de la carte réseau connectée au réseau interne, ici la carte Ethernet 2 ;
- Entrer dans les propriétés de la ligne "IPv4" :
 
	![[[Pasted image 20241009181217.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/ipv4.png)

 - Et définir l'adresse IP en 172.16.10.10 et le masque de sous-réseau en 255.255.255.0 :

  ![[[Pasted image 20241009181307.png]]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/eae98cc50b090aae0a14f00268cf52440ff07e70/Install%20Server/address.png)

- Redémarrer une dernière fois la machine pour prendre en compte tous les changements effectués.

## Configuration Partage de fichiers
### Installer le service de rôle NFS

1. Dans le menu Manage du Gestionnaire de serveur, sélectionnez **Add Roles and Features**.

![manager](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/bb76ad95af585767bc620bc8eb0125dd5bd06657/Install%20Server/manager.png)

2. Cliquez sur **Next** sur l’écran de bienvenue.
3. Sur **Installation Type** , sélectionnez **Role-based or feature-based installation**, puis cliquez sur **Next**.

![installtype](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/bb76ad95af585767bc620bc8eb0125dd5bd06657/Install%20Server/installtype.png)

4. Assurez-vous que le serveur cible approprié est sélectionné, puis cliquez sur **Next**.
5. Développez **File and Storage Services**, puis développez **File and iSCSI Services**.
6. Sélectionnez **Server for NFS**.

![roles](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/bb76ad95af585767bc620bc8eb0125dd5bd06657/Install%20Server/roles.png)

7. Cliquez sur **Add Features** dans la fenêtre d’affichage qui s’affiche, puis cliquez sur **Next** pour continuer.

![ServerforNFS](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/bb76ad95af585767bc620bc8eb0125dd5bd06657/Install%20Server/serverfornfs.png)

8. Cliquez à nouveau sur **Next** sur l’écran Features.
9. Cliquez sur **Install** sur l’écran Confirmation pour commencer l’installation.
10. Vous pouvez cliquer sur **Close** pendant l’installation ou une fois l’installation terminée.

### Créer le répertoire partagé
- Créer un répertoire à l'endroit souhaité ;
	- C'est dans ce répertoire que sera situé la base de données KeePass ;
- Entrer dans les propriétés du répertoire et aller dans l'onglet **Sharing** ;
	- Pensez à bien noter le chemin réseau, il servira par la suite pour les clients ;
- Cliquer sur **Share** ;

![share](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/bb76ad95af585767bc620bc8eb0125dd5bd06657/Install%20Server/share.png)

- Modifier les droits *Everyone* sur **Read** ;

![rights](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/bb76ad95af585767bc620bc8eb0125dd5bd06657/Install%20Server/rights.png)

- Votre machine est prête à être mise en réseau. Dans les étapes suivantes, nous installerons le logiciel KeePass et détaillerons le partage de fichier nécessaire pour un accès client.

# Etapes d'installation et configuration Windows 10
## Choix des langues


![[langue.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/langue.png)

- Une fois que le PC démarre, la première étape consiste à choisir vos préférences linguistiques.
- Puis cliquez sur installer maintenant.

## Licence et version de Windows

Une fenêtre Activer Windows s'ouvre alors et plusieurs options sont possibles : soit vous avez une clé produit (licence) et n'avez qu'à entrer son code
Une clé de produit est un code de 25 chiffres qui se présente sous la forme suivante :

CLÉ DE PRODUIT : XXXXX-XXXXX-XXXXX-XXXXX-XXXXX

Pendant l’installation, vous êtes invité à entrer une clé de produit.

## Lancer l'installation

![[choix os.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/choix%20os.png)

Sélectionnez ensuite la version de Windows qui vous convient, Windows Famille étant le choix recommandé pour les particuliers.

Acceptez les termes du contrat.

### Choix de la destination de l'installation

![[installation disque.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/installation%20disque.png)

Choisissez ensuite Personnalisé : installer uniquement Windows (avancé).

![[espace alloué.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/espace%20allou%C3%A9.png)

À la demande *Où souhaitez-vous installer Windows ?”*, plusieurs options sont possibles :
- Si votre disque est vide, sélectionnez-le et cliquez sur Suivant  
- S'il ne l'est pas, choisissez le lecteur principal et cliquez sur Formater, puis Suivant (attention, vous perdrez les données du lecteur en question, ce qui ne devrait normalement pas poser de problème).

![[instal.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/instal.png)

L'installation de Windows se lance et vous n'avez plus qu'à attendre qu'elle s'achève.

## Configurer Windows 10
### Choix des langues

![[choix langue 2.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/choix%20langue%202.png)

- Sélectionnez votre pays.

![[clavier.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/clavier.png)

- puis votre disposition de clavier.

![[clavier secondaire.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/clavier%20secondaire.png)

- et éventuellement une seconde disposition.

![[ajout compte.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/ajout%20compte.png)

- L'étape suivante exige la création d'un compte Microsoft ou, le cas échéant, de s'identifier avec celui dont vous disposez. Cliquez sur *compte hors connexion* pour s'en affranchir.

![[nom utilisateur.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/nom%20utilisateur.png)

- Créer votre nom d'utilisateur et cliquez sur suivant.
	- Pour le projet, le nom d'utilisateur choisi est : wilder

![[mot de passe.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/mot%20de%20passe.png)

- Définissez un mot de passe pour votre ordinateur.
	- Pour le projet, le mot de passe choisi est Azerty1*

-  Il faudra ensuite choisir si vous souhaiter activer différents services.

- Windows prend enfin quelques minutes pour se configurer.

- Passé ces minutes, le Bureau de Windows 10 s'affiche et l'ordinateur est prêt à être utilisé.

### Pare-feu

Dans le but de créer une liaison simple avec le serveur, il faut désactiver les pare-feu. Pour ce faire, taper pare-feu dans la barre de recherche du bureau, et selectionner *pare-feu Windows defender*. Puis selectionner *Activer ou désactiver le Pare-feu Windows Defender*, et désactiver les pare-feu de réseaux privés et publics.

![[pareu feu.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/pareu%20feu.png)

### Configuration du poste client

![[adittion invité.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/adittion%20invit%C3%A9.png)

- Dans l'onglet Périphériques de VirtualBox, insérer l'image CD des Additions invité.

![[localisation .exe guest.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/localisation%20.exe%20guest.png)

- Chercher ensuite le lecteur créer VirtualBox Guest Additions et sélectionner a l'intérieur l'exécutable VBoxWindowsAdditions. Ensuite appuyé sur next et installer et Windows redémarrera automatiquement.

### Configuration réseau

![[réseau 1.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/r%C3%A9seau%201.png)

- cliquez sur **Réseau et Internet** depuis les paramètres de Windows 10

![[réseau 2.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/r%C3%A9seau%202.png)

- Cliquez sur *Modifier les options d'adaptateur*

![[réseau 3.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/r%C3%A9seau%203.png)

- Cliquez sur les propriétés de votre carte réseau.

![[réseau 4.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/r%C3%A9seau%204.png)

- double cliquez sur *Protocole Internet version 4* 

![[réseau 5.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/r%C3%A9seau%205.png)

- Cliquez sur *Utilisez l'adresse IP suivante* et insérez l'adresse ip. ainsi que le masque de sous réseau fournit.

### Connexion au serveur

- Dans les paramètres, cliquez sur *Réseau et Internet* , *accès à distance* puis sur *centre Réseau et partage*.

- Cliquez sur *Modifier les paramètres de partage avancés* et vérifiez que la Recherche réseau et le partage de fichiers, d'imprimante et le Partage protégé par mot de passe soit activés.

- Ensuite ouvrez l'explorateur de fichiers et tapez l'adresse du serveur avec le nom du dossier comme dans la démonstration ci dessous.
  
 ![[accès serveur.png]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/image%20install%20win%2010/acc%C3%A8s%20serveur.png)

### Configuration Partage de fichiers
- Dans les fichiers Windows, sur la page **Ce PC**, dans l'onglet **Ordinateur**, choisir **Connecter un lecteur réseau** ;

![connect](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/91313c6587cb4cedd4de078fbaa68adfb5c0ed82/image%20install%20win%2010/connect.png)

- Choisir un lecteur pour monter le répertoire partagé et insérer le chemin réseau du répertoire partagé que l'on a pris en note un peu plus tôt ;

![path](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/91313c6587cb4cedd4de078fbaa68adfb5c0ed82/image%20install%20win%2010/path.png)

- Cliquer sur Terminer. Le partage est effectif.


# Etapes d'installation et configuration Ubuntu

![[etape 1]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/7eee1a7b19e1e0d27e7efcdf1d147485f4b2591e/installation_client_2_Ubuntu/etape%201%20VM.png)

- Cliquez sur "Nouveau" dans VirtualBox et sélectionnez la version d'Ubuntu souhaitée.

![[etape 2]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/3bc550c67cebfe9d3871b7a91931edb5f8236797/installation_client_2_Ubuntu/etape%202%20VM%20select%20ISO.png)

- Sélectionnez le fichier ISO d'Ubuntu et cliquez dessus.

![[etape 3]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/3bc550c67cebfe9d3871b7a91931edb5f8236797/installation_client_2_Ubuntu/etape%203%20VM%20nat%20internal%20network.png)

- Faites un clic droit sur l'Ubuntu dans la VM, allez dans les paramètres, puis sélectionnez les options réseau.
	- Configurer l'Adaptateur 1 en NAT ;
 	- Configurer l'Adaptateur 2 en Réseau interne. Assurez vous de bien choisir le même réseau interne que vos autres machines.

![[etape 4]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/be14cfceeb71d779da0114a19a850a4df38744ca/installation_client_2_Ubuntu/etape%204%20VM%20installation%20ubuntu.png)

- Après avoir démarré Ubuntu, sélectionnez l'option "Try or Install".

![[etape 5]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/be14cfceeb71d779da0114a19a850a4df38744ca/installation_client_2_Ubuntu/etape%205%20VM%20installation%20ubuntu.png)

- Après avoir sélectionné votre langue, cliquez sur "Installer Ubuntu".

![[etape 6]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/be14cfceeb71d779da0114a19a850a4df38744ca/installation_client_2_Ubuntu/etape%206%20VM%20installation%20ubuntu%20language.png)

- Réglez la langue du clavier et les options de disposition du clavier, puis cliquez sur "Continuer".

![[etape 7]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/3f0fe1a15ddaf9f16231ea25d463470a1285d44c/installation_client_2_Ubuntu/etape%207%20corrige%201.png)

- Comme montré sur l'image, sélectionnez l'option d'installation normale et cliquez sur "Continuer".

![[etape 8]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/be14cfceeb71d779da0114a19a850a4df38744ca/installation_client_2_Ubuntu/etape%208%20VM%20installation%20ubuntu%20type%20d'installation%202.png)

- Dans la fenêtre qui apparaît, cliquez sur "Continuer".

![[etape 9]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/be14cfceeb71d779da0114a19a850a4df38744ca/installation_client_2_Ubuntu/etape%209%20VM%20installation%20ubuntu%20type%20d'installation.png)

- Dans la section "Type d'installation", sélectionnez "Effacer le disque et installer Ubuntu" comme montré à l'écran, puis cliquez sur "Installer maintenant".

![[etape 10]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/be212307c9b1bdad906620a014a90e8d5d50c459/installation_client_2_Ubuntu/etape%2010%20VM%20installation%20ubuntu%20ou%20etes%20vous.png)

- À cette étape, sélectionnez votre emplacement.

![[etape 11]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/3f0fe1a15ddaf9f16231ea25d463470a1285d44c/installation_client_2_Ubuntu/etape%2011%20corrige%202.png)

- À cette étape, veuillez remplir les informations demandées en suivant les indications ci-dessous. Puis cliquez sur "Continuer".
	- Nom : CLILIN02
  	- Compte utilisateur : wilder
  	- Mot de passe : Azerty1*

![[etape 12]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/1a6658d3208a47a4c1c2880281c77fb5f257ae23/installation_client_2_Ubuntu/etape%2012%20VM%20installation%20ubuntu%20installation.png)

- À cette étape, attendez que l'installation se termine, puis la machine redémarrera.

![[etape 13]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/1a6658d3208a47a4c1c2880281c77fb5f257ae23/installation_client_2_Ubuntu/etape%2013%20VM%20installation%20ubuntu%20installation%20termin%C3%A9.png)

- Sur l'écran d'accueil, saisissez le mot de passe que vous avez défini lors de l'installation pour vous connecter à Ubuntu.

![[etape 14]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/1a6658d3208a47a4c1c2880281c77fb5f257ae23/installation_client_2_Ubuntu/etape%2014%20VM%20installation%20ubuntu%20IPv4%20etape%201.png)

- Sur le bureau, cliquez sur l'icône de réseau en haut à droite. Ensuite, sélectionnez l'Ethernet auquel vous êtes connecté et cliquez sur "Paramètres filaires".

![[etape 15]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/1a6658d3208a47a4c1c2880281c77fb5f257ae23/installation_client_2_Ubuntu/etape%2015%20VM%20installation%20ubuntu%20IPv4%20etape%202.png)

- Dans les paramètres qui s'ouvrent, cliquez sur la section "Filaire". Ensuite, entrez l'adresse IP (172.16.10.30) et le masque de réseau (255.255.255.0) comme montré à l'écran. Puis cliquez sur "Appliquer".

![[etape 16]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/aa3f495c43a9f382548513d2fa9ad08fcea4c961/installation_client_2_Ubuntu/etape%2016%20VM%20installation%20ubuntu%20IPv4%20etape%203%20verification%20ip.png)

![[etape 17]](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/aa3f495c43a9f382548513d2fa9ad08fcea4c961/installation_client_2_Ubuntu/etape%2017%20VM%20installation%20ubuntu%20IPv4%20etape%204%20verification%20ip%20v2.png)

- Ensuite, ouvrez le Terminal et tapez `ip addr show` comme montré à l'écran, puis tapez `ping 172.16.10.10` pour vérifier la connexion d'Ubuntu au serveur Windows.

## Configuration Partage de fichiers
- Ouvrez une invite de commandes et créez un répertoire pour accueillir le point de montage du répertoire partagé.

	`sudo mkdir /mnt/sharesrv`

On a choisi ici de monter dans le `/mnt` mais rien n'empêche de le monter dans un autre répertoire permanent.

- Reliez ce point de montage au répertoire partagé localisé sur le serveur.

	`sudo mount -o user=Administrator,password=Azerty1*,rw //172.16.10.10/Users/Administrator/Documents/Share /mnt/sharesrv`

Notez bien que les détails de la ligne ci-dessus reprennent la configuration globale effectuée au cours de cette documentation. Le nom d'utilisateur `user=Administrator` et mot de passe associé `password=Azerty1*` du serveur, l'adresse IP `172.16.10.10` du serveur et le chemin réseau peuvent varier sur d'autres configurations.

- Créez un lien symbolique, *symlink*, accessible pour un utilisateur vers ce point de montage. L'accès au répertoire en sera facilité pour vos utilisateurs sans avoir besoin d'entrer de ligne de commandes.

	`sudo ln -s /mnt/sharesrv ~/sharesrv`

# Étapes d'installation et de configuration de KeePass

## Pour Windows 10 :

### 1. Téléchargement de KeePass

- Rendez-vous sur le [site officiel de KeePass](https://keepass.info/).

![Capture d'écran du site KeePass](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/ImagesKeePass/Capture%20d%E2%80%99%C3%A9cran%20(16).png)

- Cliquez sur **Download** à gauche de l'écran ou [suivez ce lien](https://keepass.info/download.html).
- KeePass est disponible pour Windows, Mac et Linux. Sélectionnez la version **Windows**.

![Capture d'écran du téléchargement de KeePass](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/ImagesKeePass/Capture%20d%E2%80%99%C3%A9cran%20(17).png)

- Un nouvel onglet s'ouvre et après quelques secondes, la fenêtre de l'explorateur apparaît, vous demandant l'emplacement pour télécharger le fichier d'installation (dans mon cas, le fichier "KeePass-2.57.1-Setup.exe"). Choisissez l'emplacement et cliquez sur **Enregistrer**.

![Capture d'écran de l'explorateur](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/ImagesKeePass/Capture%20d%E2%80%99%C3%A9cran%20(18).png)

### 2. Installation de KeePass

- Attendez la fin du téléchargement puis ouvrez le fichier d'installation (**KeePass-2.57.1-Setup.exe**).
- Une première fenêtre apparaît, cliquez sur **Exécuter**, puis à la question "Voulez-vous autoriser cette application à apporter des modifications sur l'appareil ?", cliquez sur **Oui**.
- Sélectionnez la langue.
- Lisez et acceptez les **Termes et Conditions**.

![Capture d'écran des termes et conditions](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/ImagesKeePass/Capture%20d%E2%80%99%C3%A9cran%20(19).png)

- Sélectionnez **Installation complète**.

![Capture d'écran de l'installation complète](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/ImagesKeePass/Capture%20d%E2%80%99%C3%A9cran%20(20).png)

- Enfin, cliquez sur **Installer**.

![Capture d'écran du bouton installer](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/ImagesKeePass/Capture%20d%E2%80%99%C3%A9cran%20(22).png)

- L'installation est maintenant terminée ! Vous pouvez lancer KeePass et commencer à créer une base de données sécurisée.

![Capture d'écran de KeePass ouvert](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/ImagesKeePass/Capture%20d%E2%80%99%C3%A9cran%20(23).png)

### 3. Conseils et informations

Pour tirer pleinement parti des nombreuses fonctionnalités offertes par KeePass, il est fortement recommandé de consulter [la documentation officielle](https://keepass.info/help/base/faq_tech.html) ou de suivre des tutoriels en ligne. 
Il est également conseillé d'imprimer la feuille de secours, KeePass vous le propose à la création de la base de données.  

![](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/ImagesKeePass/feuilledesecours.png)  

KeePass propose également plusieurs fonctions avancées qui peuvent vous aider à renforcer encore davantage la sécurité de vos données, telles que :

- **Utilisation de plugins** : Ajoutez des fonctionnalités supplémentaires à KeePass, comme la synchronisation avec des services cloud ou l'intégration de nouveaux formats de mots de passe.
- **Générateur de mots de passe complexes** : Créez des mots de passe uniques et robustes pour chaque compte, adaptés à vos besoins de sécurité.
- **Clés matérielles et fichiers clés** : Combinez un mot de passe avec un fichier clé ou une clé USB pour une double authentification renforcée.
- **Synchronisation de bases de données** : Travaillez en équipe et synchronisez plusieurs bases de données, localement ou à travers des services cloud sécurisés.
- **Auto-Type** : Automatisez la saisie de vos identifiants sur les sites Web ou applications, tout en évitant les enregistrements potentiellement non sécurisés des navigateurs.

En adoptant ces bonnes pratiques, vous renforcerez la sécurité de vos informations sensibles et gagnerez un temps considérable tout en optimisant l'utilisation de KeePass.

---

## Pour Ubuntu :

### 1. Téléchargement de KeePass

- Ouvrez un terminal en appuyant sur `Ctrl + Alt + T`.
- Mettez à jour la liste des paquets :

```bash
sudo apt update
```

![](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/ImagesKeePass/1.png)

Installez KeePass en exécutant la commande suivante :

```bash
sudo apt install keepass2 -y
```

![](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/ImagesKeePass/2.png)

### 2. Lancement de KeePass

Une fois l'installation terminée, vous pouvez lancer KeePass en recherchant "KeePass" dans le menu des applications ou en exécutant la commande suivante dans le terminal :

```bash
keepass2
```

![](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/ImagesKeePass/3.png)

### 3. Conseils et informations

Pour tirer pleinement parti des nombreuses fonctionnalités offertes par KeePass, il est fortement recommandé de consulter [la documentation officielle](https://keepass.info/help/base/faq_tech.html) ou de suivre des tutoriels en ligne. 
Il est également conseillé d'imprimer la feuille de secours, KeePass vous le propose à la création de la base de données.  

![](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P1-G2-GestionBaseDeDonnesSecuriseeDeMotsDePasse/blob/A-verifier/ImagesKeePass/feuilledesecours.png)  

KeePass propose également plusieurs fonctions avancées qui peuvent vous aider à renforcer encore davantage la sécurité de vos données, telles que :

- **Utilisation de plugins** : Ajoutez des fonctionnalités supplémentaires à KeePass, comme la synchronisation avec des services cloud ou l'intégration de nouveaux formats de mots de passe.
- **Générateur de mots de passe complexes** : Créez des mots de passe uniques et robustes pour chaque compte, adaptés à vos besoins de sécurité.
- **Clés matérielles et fichiers clés** : Combinez un mot de passe avec un fichier clé ou une clé USB pour une double authentification renforcée.
- **Synchronisation de bases de données** : Travaillez en équipe et synchronisez plusieurs bases de données, localement ou à travers des services cloud sécurisés.
- **Auto-Type** : Automatisez la saisie de vos identifiants sur les sites Web ou applications, tout en évitant les enregistrements potentiellement non sécurisés des navigateurs.

En adoptant ces bonnes pratiques, vous renforcerez la sécurité de vos informations sensibles et gagnerez un temps considérable tout en optimisant l'utilisation de KeePass.


# FAQ

## Pourquoi KeePass essaie-t-il de se connecter à Internet?

KeePass a une option pour vérifier automatiquement les mises à jour à chaque démarrage du programme. Pour vérifier les mises à jour, KeePass télécharge une petite version fichier et compare la version disponible avec la version installée. Aucune information personnelle n'est envoyée au serveur web KeePass.

Les vérifications automatiques de mise à jour sont effectuées de manière inintrusive en arrière-plan. Une notification s'affiche uniquement lorsqu'une mise à jour est disponible. Les mises à jour ne sont pas téléchargées ou installées automatiquement.

Lorsque vous démarrez KeePass pour la première fois, il vous demande si vous souhaitez activer vérifications de mise à jour automatique (recommandé). Ils peuvent être activés/désactivés à tout moment temps d'utilisation de l'option dans 'Outils' → 'Options' → onglet 'Avancé'.


## Pourquoi la qualité estimée d'un mot de passe diminue-t-elle soudainement?

Pour estimer la qualité/force d'un mot de passe, KeePass n'utilise pas seulement méthodes statistiques (comme la vérification des plages de caractères utilisées, par exemple répétant des caractères et des différences), il a également une liste intégrée de mots de passe et vérifications courants des modèles. Lorsque vous remplissez un mot de passe commun ou un répétition, la qualité estimée peut baisser.


##  Le GUI prend-il en charge les thèmes sombres?

Oui. KeePass prend en charge tous les thèmes système, y compris les thèmes sombres.

- Sous Windows 11, un thème (sombre) peut être sélectionné dans le Paramètres Windows → 'Accessibilité' → 'Thèmes de contraste'.
- Sous Windows 10, un thème (sombre) peut être sélectionné dans le Paramètres Windows → 'Facilité d'accès' → 'Contraste élevé'.
- Sous Windows 7, 8 et 8.1, un thème (sombre) peut être sélectionné dans le Panneau de configuration Windows → 'Apparence et personnalisation' → 'Personnalisation'.

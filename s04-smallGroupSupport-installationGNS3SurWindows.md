# 1. Prérequis

Télécharger les sources :

* **GNS3 2.2.34** : [lien GNS3](https://gns3.com/software/download)

* **GNS3 VM 2.2.34** : [lien GNS3 VM](https://gns3.com/software/download-vm)
Prendre la version ***VMWare Workstation and Fusion***.
* **VMware Worlstation Player 16.2.4** : [lien VMware Workstation Player](https://customerconnect.vmware.com/en/downloads/details?downloadGroup=WKST-PLAYER-1624&productId=1039&rPId=91446)
Prendre la version ***VMware Workstation 16.2.4 Player for Windows 64-bit Operating Systems***.

> Tu n'est pas obligé d'utiliser VMware comme hyperviseur, tu peux garder Virtualbox si tu veux.
> VMware est néanmoins recommandé car il est plus optimisé avec GNS3 que Virtualbox.

# 2. Suppression d'une ancienne installation (à faire obligatoirement)

Si cette installation fait suite à un dysfonctionnement, faire les actions ci-dessous :

* Télécharger et installer le logiciel **ccleaner** (version gratuite) disponible [ici](https://www.ccleaner.com/fr-fr/ccleaner/download).
* Supprimer **GNS3**
  * A la fenêtre `Uninstall` cliquer sur `Non` pour garder les paramètres
* Supprimer les hyperviseurs installés comme **Virtualbox** ou **VMware**
  * Choisir de ne pas garder les configurations
* Redémarrer l'ordinateur
* Exécuter **ccleaner** et faire un nettoyage dans les onglets **Nettoyage personnalisé** et **Registre**
* Faire une recherche ***gns3*** dans l'arborescence de fichiers et supprimer les dossiers trouvé
* Redémarrer l'ordinateur

# 3. Installation de WMware Workstation Player

* Lancer le fichier d'installation exécutable de VMware
* Cliquer sur `Next` plusieurs fois
* Cocher les cases `Enhanced Keyboard...` et `Add VMware Workstation...`
* Décocher les cases `Check for product updates ...` et `Join the VMware Customer...`
* Cliquer sur `Next` puis `Install`
* Cliquer sur `Finish` pour terminer l'installation
* Redémarrer l'ordinateur

# 4. Mise en place de la VM GNS3

* Décompresser le fichier zip qui contient la VM GNS3 dans un dossier.
* Lancer l’exécutable de VMware Workstation Player
* Au démarrage, choisir `Use VMware Workstation 16 Player for free...` et cliquer sur `Continue`
* Cliquer sur `Finish` pour terminer l'installation
* Après le lancement, aller dans `File --> Open` pour aller chercher le fichier de la VM GNS3
* Donner un nom à la VM pour l'importation, comme **GNS3VM**
* Vérifier que l'emplacement de stockage est bien sous `*\Documents\Virtual Machines\`
* Cliquer sur `Import`
* Une fois l'importation terminée, la VM apparaît dans la liste des VM.
* Fermer VMware

# 5. Installation de GNS3

* Lancer l’exécutable de GNS3
* Cliquer sur `Next` plusieurs fois
* A la fenêtre de choix des composants, laisser tout par défaut sauf `Solar-Putty` qu'il faut décocher.
* Cliquer sur `Next` plusieurs fois jusqu'à ce que l'installation commence
* A la fenêtre `Solarwinds Standard Toolset` choisir `No` et cliquer sur `Next`
* Cliquer sur `Finish` pour terminer l'installation
* Au démarrage de GNS3, choisir `Run appliance in a virtual machine`
* A la fenêtre d'erreur, cliquer sur `Ok`
* Dans la fenêtre d'après, sélectionner **VMware** et dans la partie `VM name` sélectionner la VM GNS3
* Cliquer sur `Next` puis sur `Finish` pour terminer l'installation

# 6. Fonctionnement de GNS3 avec une VM

Au lancement de GNS3, VMware va se lancer et exécuter la VM GNS3 en arrière-plan.
On peut diminuer la fenêtre mais il ne faut pas la fermer !

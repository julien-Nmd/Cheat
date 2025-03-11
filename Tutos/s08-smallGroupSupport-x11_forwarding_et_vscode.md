VM :
- Client Ubuntu 24.04 LTS (172.16.10.20/24)
- Serveur Debian 12 (172.16.10.10/24)

# 1. SSH

Installation ssh :
[s10-atelier-SSH](02-atelier/s10-atelier-ssh.md)

# 2. Préparation VM

- Aller sur le site de VSCode (https://code.visualstudio.com/) et télécharger le fichier **.deb**
- Au même emplacement créer les 2 scripts :
**copy.sh**
```shell
#!/bin/bash
fileSource1="/home/wilder/Téléchargements/code_*_amd64.deb"
fileSource2="/home/wilder/Téléchargements/install.sh"
directoryDest="/home/wilder/"
# Copie des sources sur le serveur
scp $fileSource1 $fileSource2 wilder@172.16.10.10:$directoryDest
```

Et :
**install.sh**
```shell
#!/bin/bash
# MAJ des dépôts
apt update
# VSCODE
# Recherche fichier .deb de VSCode
vscodeFile=$(ls | grep -E "code.*amd64.deb")
dpkg -i $vscodeFile
# Si dépendances manquantes
apt -f install -y
# X11-APPS
apt install x11-apps -y
# GEDIT
apt install gedit -y
apt install libcanberra-gtk-module -y
# Nettoyage des paquets inutiles
apt autoremove
```

- Exécuter le script ` copy.sh` 
- Se connecter en ssh sur le serveur avec un compte standard (_wilder_)
- Passer en root
- Mettre le compte dans le groupe sudo : `usermod -aG sudo wilder`
- Sortir de la connexion ssh et se reconnecter (valide les droits modifiés précédemment) avec l'option ` -X` 
- Exécuter le script `install.sh` 
- On peut vérifier que l'espace disque change sur le serveur avec ` watch -n 2 "df -h | grep '/dev/mapper/debian--vg-root'"` 
- Tester à partir du client Ubuntu, en ssh (X11) les applications :
	- xeyes
	- gedit
	- code (VSCode)




---
noteID: feebd9d7-bd82-41d3-8267-43c7f157f779
---
# 1. Fonction de hash

## a. Exemple
```bash
wilder@UbuDemo:~$ echo "test" > testhash.txt
wilder@UbuDemo:~$ sha256sum testhash.txt
f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2  testhash.txt

wilder@UbuDemo:~$ echo "" >> testhash.txt 
wilder@UbuDemo:~$ sha256sum testhash.txt 
dc122cd797e76d1e0b07efe6262829098581816f1727d9a883bd4052a4e659ef  testhash.txt
```

## b. Utilité

Aller sur le site de virtualbox et télécharger un fichier.
Exemple avec le **VirtualBox-7.1.4-165100-Win**.

Sur le site, liste des hash de la version 7.1.4 (https://www.virtualbox.org/download/hashes/7.1.4/SHA256SUMS) donne :
`f970e275f59eeeb129aab88a78dae80784370742b5051650a7926c9ea64afeac *VirtualBox-7.1.4-165100-Win.exe`

SHA du fichier téléchargé : 
```bash
dom@lapbuntu:~/Téléchargements$ sha256sum VirtualBox-7.1.4-165100-Win.exe 
f970e275f59eeeb129aab88a78dae80784370742b5051650a7926c9ea64afeac  VirtualBox-7.1.4-165100-Win.exe
```

Attention :
```bash
# Passage du nom du fichier dans le sha256
dom@lapbuntu:~/Téléchargements$ ls | grep Vir | sha256sum
91279cb7480a13b364a4a897e513fc65281242b70addfbe96619ac92386d98d9  -

# Avec xargs passage du fichier dans le sha256
dom@lapbuntu:~/Téléchargements$ ls | grep Vir | xargs sha256sum
f970e275f59eeeb129aab88a78dae80784370742b5051650a7926c9ea64afeac  VirtualBox-7.1.4-165100-Win.exe
```

# 2. Signature numérique

## a. Création de clés publique et privée

```bash
# Generation d'une clé privée
wilder@UbuDemo:~$ openssl genpkey -algorithm RSA -out private_key.pem
```

```bash
# Génération d'un clé publique
wilder@UbuDemo:~$ openssl rsa -in private_key.pem -pubout -out public_key.pem
```

## b. Création d'un fichier signé

```bash
# Création d'un fichier
wilder@UbuDemo:~$ touch testSignature.txt

# Signature du fichier
wilder@UbuDemo:~$ openssl dgst -sha256 -sign private_key.pem -out signature.sig testSignature.txt
# Vérification du fichier
wilder@UbuDemo:~$ openssl dgst -sha256 -verify public_key.pem -signature signature.sig testSignature.txt

# Modification du fichier
wilder@UbuDemo:~$ nano testSignature.txt 
# Vérification du fichier
wilder@UbuDemo:~$ openssl dgst -sha256 -verify public_key.pem -signature signature.sig testSignature.txt
```

# 3. Certificat
## a. Création de certificat auto-signé

```bash
wilder@UbuDemo:~$ openssl req -new -x509 -key private_key.pem -out certificat.crt -days 365

# Détails
wilder@UbuDemo:~$ openssl x509 -in certificat.crt -text -noout
```
## b. Mise en place d'un serveur web avec certificat

```
sudo apt update
sudo apt install apache2
sudo a2enmod ssl
```

Créer un dossier pour les certificats :

```
sudo mkdir /etc/apache2/ssl
sudo cp private_key.pem /etc/apache2/ssl/
sudo cp certificat.crt /etc/apache2/ssl/
```

Configuration d'un virtualhost :
```
sudo nano /etc/apache2/sites-available/secure-site.conf
```

Ajouter les lignes suivantes :

```apache
<VirtualHost *:443>
    ServerName localhost
    DocumentRoot /var/www/html

    SSLEngine on
    SSLCertificateFile /etc/apache2/ssl/certificat.crt
    SSLCertificateKeyFile /etc/apache2/ssl/private_key.pem
</VirtualHost>
```


Activation du site :

```
sudo a2ensite secure-site.conf
sudo systemctl restart apache2
```

Test en http et https => erreur
https://localhost

## b. Importer le certificat

Dans Firefox aller dans Paramètres -> Vie privée et sécurité -> Certificats -> Afficher les certificats -> Autorités
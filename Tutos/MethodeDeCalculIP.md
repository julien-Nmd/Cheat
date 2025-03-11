
# 1. Conversion IP v4

| 8ème bit | 7ème bit  | 6ème bit  | 5ème bit  | 4ème bit  | 3ème bit  | 2ème bit  | 1er bit |
|-----|-----|-----|-----|-----|-----|-----|-----|
| 2^7 | 2^6 | 2^5 | 2^4 | 2^3 | 2^2 | 2^1 | 2^0 |
| 128 | 64  | 32  | 16  | 8   | 4   | 2   | 1   |

### 1.1 Conversion décimale - binaire

**Exemple : 192.168.1.58**

1er octet **192** :

| 8ème bit | 7ème bit  | 6ème bit  | 5ème bit  | 4ème bit  | 3ème bit  | 2ème bit  | 1er bit |
|-----|-----|-----|-----|-----|-----|-----|-----|
| 2^7 | 2^6 | 2^5 | 2^4 | 2^3 | 2^2 | 2^1 | 2^0 |
| 128 | 64  | 32  | 16  | 8   | 4   | 2   | 1   |
| x   | x   | x   | x   | x   |  x  | x   | x   |
| 1   | 1   | 0   | 0   | 0   | 0   | 0   | 0   |

192 = 128 + 64
      = 1x128 + 1x64 + 0x32 + 0x16 + 0x8 + 0x4 + 0x2 + 0x1
      -> 11000000

2eme octet **168** :

| 8ème bit | 7ème bit  | 6ème bit  | 5ème bit  | 4ème bit  | 3ème bit  | 2ème bit  | 1er bit |
|-----|-----|-----|-----|-----|-----|-----|-----|
| 2^7 | 2^6 | 2^5 | 2^4 | 2^3 | 2^2 | 2^1 | 2^0 |
| 128 | 64  | 32  | 16  | 8   | 4   | 2   | 1   |
| x   | x   | x   | x   | x   |  x  | x   | x   |
| 1   | 0   | 1   | 0   | 1   | 0   | 0   | 0   |

168 = 128 + 32 + 8
      = 1x128 + 0x64 + 1x32 + 0x16 + 1x8 + 0x4 + 0x2 + 0x1
      -> 10101000

Et ainsi de suite...
192.168.1.58 -> 11000000.10101000.00000001.00111010

### 1.2. Conversion binaire - décimale

**Exemple : 10101100.00010000.01010111.01101110**

1er octet **10101100** :

| 8ème bit | 7ème bit  | 6ème bit  | 5ème bit  | 4ème bit  | 3ème bit  | 2ème bit  | 1er bit |
|-----|-----|-----|-----|-----|-----|-----|-----|
| 2^7 | 2^6 | 2^5 | 2^4 | 2^3 | 2^2 | 2^1 | 2^0 |
| 128 | 64  | 32  | 16  | 8   | 4   | 2   | 1   |
| x   | x   | x   | x   | x   |  x  | x   | x   |
| 1   | 0   | 1   | 0   | 1   | 1   | 0   | 0   |

10101100 -> 1x128 + 0x64 + 1x32 + 0x16 + 1x8 + 1x4 + 0x2 + 0x1
                = 128+32+8+4
                = 172

2eme octet **00010000** :

| 8ème bit | 7ème bit  | 6ème bit  | 5ème bit  | 4ème bit  | 3ème bit  | 2ème bit  | 1er bit |
|-----|-----|-----|-----|-----|-----|-----|-----|
| 2^7 | 2^6 | 2^5 | 2^4 | 2^3 | 2^2 | 2^1 | 2^0 |
| 128 | 64  | 32  | 16  | 8   | 4   | 2   | 1   |
| x   | x   | x   | x   | x   |  x  | x   | x   |
| 0   | 0   | 0   | 1   | 0   | 0   | 0   | 0   |

00010000 -> 0x128 + 0x64 + 0x32 + 1x16 + 0x8 + 0x4 + 0x2 + 0x1
                = 16

10101100.00010000.01010111.01101110 -> 172.16.87.110

# 2. Méthode

## a. Adresse réseau

### i. Méthode binaire

Faire un ET logique entre l'@IP en binaire et le masque en binaire.
Faire une conversion binaire-décimal pour avoir l'@IP de réseaux.

Exemple avec l'adresse IP **10.10.59.74/26** :

/26 => travail sur l'octet 4
Adresse de réseau sera 10.10.59.?/26

Adresse IP :                            00001010.00001010.00111011.01001010
Masque de sous-réseaux :    11111111.11111111.11111111.11000000 (255.255.255.192)
ET logique
adresse réseau :                     00001010.00001010.00111011.01000000
=> Adresse réseau : 10.10.59.64/26

### ii. Méthode "magique"

Avec le CIDR, voir sur quel octet le changement de valeur se fera :
- En dessous de /9
- Entre /9 et /16   => travail sur le 2eme octet
- Entre /17 et /24 => 3eme octet
- A partir de /25   => 4eme octet
Faire :
256 - valeur sur le même octet pour le masque = X
1) Trouver le multiple de X inférieur ou égal à la valeur de l'octet de l'@IP
ou
2) calculer valeur sur le même octet pour l'@IP / X
Faire l'arrondi inférieur du résultat trouvé
arrondi trouvé * X = valeur de l'octet pour le début de la plage

Exemple avec l'adresse IP **10.10.59.74/26** :

/26 => travail sur l'octet 4
Adresse de réseau sera 10.10.59.?/26

Masque de sous-réseaux /26 => 255.255.255.192

256-192 (4èm octet masque) = 64
=> 64 @IP disponibles (avec @ de réseau et @ de broadcast) sur l'octet 4
=> les sous-réseaux sont délimités par des multiples de 64 sur le 4eme octet (0, 64, 128, ...).

On cherche le multiple de 64 inférieur ou égale à la valeur du 4em octet de l'@IP (soit 74) :
1) C'est donc 64
2) Sinon 74 (4eme octet de l'adresse IP) / 64 = 1,... soit 1 à l'arrondi inférieur
1 x 64 = 64 => valeur de l'octet pour le début de la plage d'adresse

=> Adresse réseau : 10.10.59.64/26

## b. Nombre d'hôtes

Faire le calcul 2 ^ (32 - CIDR) - 2

Exemple avec l'adresse IP **10.10.59.74/26** :

2 ^ (32 - 26) - 2
= 2 ^ 6 - 2
= 64 - 2
= 62

=> Nombre d'hôtes maximum : 62

## c. Adresse de broadcast

### i. Méthode "magique"

Avec le CIDR, voir sur quel octet le changement de valeur se fera :
- En dessous de /9
- Entre /9 et /16   => travail sur le 2eme octet
- Entre /17 et /24 => 3eme octet
- A partir de /25   => 4eme octet

Faire :
256 - valeur sur le même octet pour le masque = X
Trouver le multiple de X supérieur à la valeur de l'octet de l'@ de réseaux et enlever 1

valeur trouvée = valeur de l'octet pour l'adresse de broadcast

Exemple avec l'adresse IP **10.10.59.74/26** :

/26 => travail sur l'octet 4
Adresse de broadcast sera 10.10.59.?

256-192 (4èm octet masque) = 64

valeur de l'octet est supérieur à la valeur de début de la plage d'adresse - 1 :
Valeur pour l'adresse de réseau : 64 (sur l'octet 4)
64 + 64  - 1 = 127

Adresse de broadcast : 10.10.59.127

### ii. Méthode avec nombre d'hôtes

Avec le CIDR, voir sur quel octet le changement de valeur se fera :
- En dessous de /9
- Entre /9 et /16   => travail sur le 2eme octet
- Entre /17 et /24 => 3eme octet
- A partir de /25   => 4eme octet

Si octet 1 : 256 x 256 x 256 sous-réseaux possibles
Si octet 2 : 256 x 256 sous-réseaux possibles
Si octet 3 : 256 sous-réseaux possibles
Si octet 4 : 1 sous-réseaux

On calcul : (Nombre d'hôtes  + 2) / nombre de sous-réseaux
Trouver le multiple de X supérieur à la valeur de l'octet de l'@ de réseaux et enlever 1

Valeur trouvée = valeur de l'octet pour l'adresse de broadcast

Exemple avec l'adresse IP **10.10.59.74/26** :

/26 => travail sur l'octet 4
Adresse de broadcast sera 10.10.59.?

Il y a 1 sous-réseaux
Nombre d'hôtes = 62

(62 + 2) / 1 = 64
Valeur pour l'adresse de réseau : 64 (sur l'octet 4)
64 + 64 - 1 = 127

Adresse de broadcast : 10.10.59.127

### iii. Méthode avec masque inversé

Trouver le masque inversé.
Faire un OU logique entre l'@ de réseaux et le masque inversé en binaire.
Faire une conversion binaire-décimal pour avoir l'@IP de broadcast.

Exemple avec l'adresse IP **10.10.59.74/26** :

Pour 10.10.59.74/26

Adresse IP :                                        00001010. 00001010.00111011.01001010
Masque de sous-réseaux (/26) : 11111111.11111111.11111111.11000000 (255.255.255.192)
On cherche le masque inversé :  00000000.00000000.00000000.00111111

OU logique entre adresse réseau et masque inversé :
Adresse réseau :              00001010.00001010.00111011.01000000
Masque inversé :            00000000.00000000.00000000.00111111

Adresse de broadcast : 00001010.00001010.00111011.01111111

soit 10.10.59.127

# 3. Exemple 1 - 172.16.100.18/17

## a. Adresse réseau

### i. Méthode binaire

/17 => travail sur l'octet 3
Adresse de réseau sera 172.16.?.0/17

Adresse IP :                              10101100.00010000.01100100.00010010
Masque de sous-réseaux : 11111111.11111111.10000000.00000000 (255.255.128.0)
ET logique
Adresse réseau :                     10101100.00010000.00000000.00000000
Adresse réseau : 172.16.0.0/17

### ii. Méthode "magique"

/17 => travail sur l'octet 3
Adresse de réseau sera 172.16.?.0/17

Masque de sous-réseaux /17 => 255.255.128.0

256-128 (3em octet du masque) = 128
=> 128 @IP disponibles (avec @ de réseau et @ de broadcast) sur l'octet 3
=> les sous-réseaux sont délimités par des multiples de 128 sur le 3eme octet (0, 128).

On cherche le multiple de 128 inférieur ou égale à la valeur du 3em octet de l'@IP (soit 100) :
1) C'est donc 0
2) Sinon 100 (3eme octet de l'adresse IP) /128 = 0,... soit 0 à l'arrondi inférieur
0 x 128 = 0 => valeur de l'octet pour le début de la plage d'adresse

=> Adresse réseau : 172.16.0.0/17

## b. Nombre d'hôtes

2 ^ (32 - 17) - 2
= 2 ^ 15 - 2
= 32768 - 2
= 32766

=> Nombre d'hôtes maximum : 32766

## c. Adresse de broadcast

### i. Méthode "magique"

/17 => travail sur l'octet 3
Adresse de broadcast sera 172.16.?.255

256-128 (3em octet du masque) = 128

valeur de l'octet est supérieur à la valeur de début de la plage d'adresse - 1 :
Valeur pour l'adresse de réseau : 0 (sur l'octet 3)
0 + 128 - 1 = 127

=> Adresse de broadcast = 172.16.127.255

### ii. Méthode avec nombre d'hôtes

/17 => travail sur l'octet 3
Adresse de broadcast sera 172.16.?.255

Il y a 256 sous-réseaux
Nombre d'hôtes = 32766

(32766 + 2) / 256 = 128
Valeur pour l'adresse de réseau : 0 (sur l'octet 3)
0 + 128 - 1 = 127

=> Adresse de broadcast = 172.16.127.255

### iii. Méthode avec masque inversé

Adresse IP :                                        10101100.00010000.01100100.00010010
Masque de sous-réseaux (/17) : 11111111.11111111.10000000.00000000 (255.255.128.0)
On cherche le masque inversé : 00000000.00000000.01111111.11111111

OU logique entre adresse réseau et masque inversé :
Adresse réseau :             10101100.00010000.00000000.00000000
Masque inversé :            00000000.00000000.01111111.11111111

Adresse de broadcast : 10101100.00010000.01111111.11111111

soit 172.16.127.255

# 4. Exemple 1 - 172.18.94.78/13

## a. Adresse réseau

### i. Méthode binaire

/13 => travail sur l'octet 2
Adresse de réseau sera 172.?.0.0/13

Adresse IP :                             10101100.00010010.01011110.01001110
Masque de sous-réseaux : 11111111.11111000.00000000.00000000 (255.248.0.0)
ET logique
adresse réseau :                    10101100.00010000.00000000.00000000
=> Adresse réseau : 172.16.0.0/13

### ii. Méthode "magique"

/13 => travail sur l'octet 2
Adresse de réseau sera 172.?.0.0/13

Masque de sous-réseaux /13 => 255.248.0.0

256-248 (2em octet du masque) = 8
=> 8 @IP disponibles (avec @ de réseau et @ de broadcast) sur l'octet 2
=> les sous-réseaux sont délimités par des multiples de 8 sur le 2eme octet (0, 8, 16, ..., 248, ...).

On cherche le multiple de 8 inférieur ou égale à la valeur du 2em octet de l'@IP (soit 18) :
1) 8 + 8 = 16
2) Sinon 18 (2eme octet de l'adresse IP) / 8 = 2,... soit 2 à l'arrondi inférieur
2 x 8 = 16 => valeur de l'octet pour le début de la plage d'adresse

=> Adresse réseau : 172.16.0.0/13

## b. Nombre d'hôtes

2 ^ (32 - 13) - 2
= 2 ^ 19 - 2
= 524288 - 2
= 524286

=> Nombre d'hôtes maximum : 524286

## c. Adresse de broadcast

### i. Méthode "magique"

/13 => travail sur l'octet 2
Adresse de broadcast sera 172.?.255.255

256-248 (2em octet du masque) = 8

valeur de l'octet est supérieur à la valeur de début de la plage d'adresse - 1 :
Valeur pour l'adresse de réseau : 16 (sur l'octet 2)
16 + 8 - 1 = 23

=> Adresse de broadcast = 172.23.255.255

### ii. Méthode avec nombre d'hôtes

/13 => travail sur l'octet 2
Adresse de broadcast sera 172.?.255.255

Il y a 256 x 256 sous-réseaux possibles, soit 65536
Nombre d'hôtes = 524286

(524286 + 2) / 65536 = 8
Valeur pour l'adresse de réseau : 16 (sur l'octet 2)
16 + 8 - 1 = 23

=> Adresse de broadcast = 172.23.255.255

### iii. Méthode avec masque inversé

Adresse IP :                                        10101100.00010010.01011110.01001110
Masque de sous-réseaux (/13) : 11111111.11111000.00000000.00000000 (255.248.0.0)
On cherche le masque inversé : 00000000.00000111.11111111.11111111

OU logique entre adresse réseau et masque inversé :
Adresse réseau :              10101100.00010000.00000000.00000000
Masque inversé :             00000000.00000111.11111111.11111111

Adresse de broadcast :   10101100.00010111.11111111.11111111

soit 172.23.255.255

# 5. Exemple 1 - 10.223.85.192/11

## a. Adresse réseau

### i. Méthode binaire

/11 => travail sur l'octet 2
Adresse de réseau sera 10.?.0.0/11

Adresse IP :                             00001010.11011111.01010101.11000000
Masque de sous-réseaux : 11111111.11100000.00000000.00000000 (255.224.0.0)
ET logique
adresse réseau :                    00001010.11000000.00000000.00000000
=> Adresse réseau : 10.192.0.0/11

### ii. Méthode "magique"

/11 => travail sur l'octet 2
Adresse de réseau sera 10.?.0.0/11

Masque de sous-réseaux /11 => 255.224.0.0

256-224 (2em octet du masque) = 32
=> 32 @IP disponibles (avec @ de réseau et @ de broadcast) sur l'octet 2
=> les sous-réseaux sont délimités par des multiples de 32 sur le 2eme octet (0, 32, 64, ...).

On cherche le multiple de 32 inférieur ou égale à la valeur du 2em octet de l'@IP (soit 223) :
1) 32 + 32 + 32 + 32 + 32 + 32 = 192
2) Sinon 223 (2eme octet de l'adresse IP) / 32 = 6,... soit 6 à l'arrondi inférieur
6 x 32 = 192 => valeur de l'octet pour le début de la plage d'adresse

=> Adresse réseau : 10.192.0.0/11

## b. Nombre d'hôtes

2 ^ (32 - 11) - 2
= 2 ^ 21 - 2
= 2097152 - 2
= 2097150

=> Nombre d'hôtes maximum : 2097150

## c. Adresse de broadcast

### i. Méthode "magique"

/11 => travail sur l'octet 2
Adresse de broadcast sera 10.?.255.255

256-224 (2em octet du masque) = 32

valeur de l'octet est supérieur à la valeur de début de la plage d'adresse - 1 :
Valeur pour l'adresse de réseau : 192 (sur l'octet 2)
192 + 32 - 1  = 223

=> Adresse de broadcast = 10.223.255.255

### ii. Méthode avec nombre d'hôtes

/11 => travail sur l'octet 2
Adresse de broadcast sera 10.?.255.255

Il y a 256 x 256 sous-réseaux possibles, soit 65536
Nombre d'hôtes = 2097150

(2097150 + 2) / 65536 = 32
Valeur pour l'adresse de réseau : 192 (sur l'octet 2)
192 + 32 - 1 = 223

=> Adresse de broadcast = 10.223.255.255

### iii. Méthode avec masque inversé

Adresse IP :                                        00001010.11011111.01010101.11000000
Masque de sous-réseaux (/11) : 11111111.11100000.00000000.00000000 (255.224.0.0)
On cherche le masque inversé : 00000000.00011111.11111111.11111111

OU logique entre adresse réseau et masque inversé :
Adresse réseau :               00001010.11000000.00000000.00000000
Masque inversé :             00000000.00011111.11111111.11111111

Adresse de broadcast :   00001010.11011111.11111111.11111111

soit 10.223.255.255


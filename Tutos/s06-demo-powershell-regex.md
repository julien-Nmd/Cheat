Objectif :
Trouver des adresses IP dans du texte.

# 1. Débuter avec les wildcards

=> Pour faire des recherches de fichiers en utilisant des caractères génériques
Utilisation de `-like`

## a. La base

`*` -> aucun ou plusieurs caractères
`?` -> 1 caractère à la position
`[x-y ] ` -> prise en compte des caractères de la plage
`[x,y ] ` -> prise en compte des caractères unique de la plage

## b. Quelques exemples

Script Wilcards.ps1

```powershell
"ABCDEF" -like "A*"
True

"ABCDEF" -like "*A"
False

"ABCDEF".Substring(2,3) -like "C"
False

"ABCDEF".Substring(2,3) -like "*[C-E]*"
True

"ABCDEF" -like "*[D-F]"
True

"ABCDEF" -like "[A,B,E]BCDEF"
True
```


```powershell
PS C:\Temp\> Get-ChildItem -Path "C:\" -Filter "Program??????"
 Répertoire : C:\

Mode                 LastWriteTime         Length Name                           
----                 -------------         ------ ----                           
d-r---        28/01/2024     20:33                Program Files
```


```powershell
# Avoir 2 dossiers c:\temp\prog1 et c:\temp\prog23
PS C:\Temp\> (Get-ChildItem -Path "C:\","C:\temp" -Filter "Prog*" | Select-Object -Property FullName).FullName

C:\Program Files
C:\Program Files (x86)
C:\temp\prog1
C:\temp\prog23

(Get-ChildItem -Path "C:\","C:\temp" -Filter "Prog??" | Select-Object -Property FullName).FullName

C:\temp\prog1
C:\temp\prog23

(Get-ChildItem -Path "C:\","C:\temp" -Filter "Prog?" | Select-Object -Property FullName).FullName

C:\temp\prog1
```

# 2. Débuter avec les regex

Recherche avancée dans les chaines de caractères.
Utilisation de :
- `-match`
- `-replace`
- `-split`
- `Select-String`

## a. La base

`\d` -> 	1 chiffre
`\D` -> 1 caractère qui n'est pas un chiffre
`\s` -> 1 caractère espace
`\S` -> 1 caractère qui n'est pas un espace
`\n` -> 1 saut de ligne
`.` -> N'importe quel caractère sauf un saut de ligne

## b. Quelques exemples

Script Regex.ps1

```powershell
"123" -match "\d"
True

"abc" -match "\D"
True

" " -match "\s"
True

"abc" -match "\S"
True

"`n" -match "\n"
True

"a" -match "."
True
```

## c. Aller plus loin

`^` -> Début de ligne
`$` -> Fin de ligne
`\t` -> Tabulation
`r` -> Retour à la ligne
`[xxx]` -> N'importe quel caractère de la liste
`[^xxx]` -> Aucun caractère de la liste
`{n}` -> n fois 
`a|b` -> a ou b
`(xxx)` -> pattern

## d. D'autres exemples

```powershell
"On est en 2024" -match "\d{4}"
True

"On est en 2024 !" -match "\d{4}"
True

"On est en 2024 !" -match "\d{4}\!$"
False

"On est en 2024 !" -match "\d{4}.\!$"
True
```

Un site pour aller plus loin :
https://www.pdq.com/blog/how-to-use-regular-expression-in-powershell/#what-is-regular-expression-regex

# 3. Regex pour numéro de téléphone

## a. Premier test

```powershell
# regex numéro de téléphone
"Téléphone : 02.74.65.89.56" -match "\d\d.\d\d.\d\d.\d\d.\d\d"
True
# \d\d n'empèche pas des chiffres en plus
"Téléphone : 102.74.65.89.56" -match "\d\d.\d\d.\d\d.\d\d.\d\d"
True
# \d\d n'empèche pas des nombres incorrect comme ici 24 au lieu de 01, 02, etc.
"Téléphone : 24.74.46.89.56" -match "\d\d.\d\d.\d\d.\d\d.\d\d"
True
# . n'empèche pas un tiret à la place du point séparateur
"Téléphone : 24-74-65-89-56" -match "\d\d.\d\d.\d\d.\d\d.\d\d"
True
```

## b. Autres test

```powershell
# Restriction avec \. au lieu de .
"Téléphone : 10.74.65-89.56" -match "\d\d\.\d\d\.\d\d\.\d\d.\d\d"
False
# Restriction avec \. au lieu de . Mais avec une autre "erreur"
"Téléphone : 410.74.65-89.56" -match "\d\d\.\d\d\.\d\d\.\d\d.\d\d"
False

# Regex correct avec le format et le nombre d'éléments attendu
"Téléphone : 04.75.65.89.56" -match "(0[1-5]\.\d{2}\.\d{2}\.\d{2}\.\d{2})"
True
```

## c. Utilisation dans un script

```powershell
# Exemple dans un script
$Tel              = "Téléphone : 04.75.65.89.56"
$NumTel           = $Tel.Split(":")[1].TrimEnd().TrimStart()
$ValidationNumTel = $NumTel -match "^(0[1-5]\.\d{2}\.\d{2}\.\d{2}\.\d{2})$"
$ValidationNumTel
```

# 4. Regex pour adresse IP

## a. Premier test

```powershell
"192.168.110.220" -match "\d\d\d\.\d\d\d\.\d\d\d\.\d\d\d"
True

"192.168.10.58" -match "\d\d\d\.\d\d\d\.\d\d\d\.\d\d\d"
False
```

## b. Autres test

```powershell
"224" -match "([0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])"
True
```

Un site pour aller plus loin :
https://ihateregex.io/

Regex trouvée :
```
(?<!\d\.)(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?!\d|\.\d)"
```

> `(?<!\d\.)` => Assertion négative (vérifie que pas de chiffre avec `.` au début)
> `(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)` => chaque octet de l'adresse :
> 	`25[0-5]` => Nombre compris entre 250 et 255
> 	`2[0-4][0-9]`: Nombre compris entre 200 et 249
> 	`[01]?[0-9][0-9]?` : Nombre compris entre 0 et 199 (1er chiffre facultatif)
> `\.` => Point entre chaque octet
> `(?!\d|\.\d)` => Assertion négative pour vérification fin d'adresse

## c. Utilisation dans un script

Avoir un script file50.txt avec des @IP aléatoire dedans

```powershell
Clear-Host
$File = "C:\Temp\file50.txt"
$GcFile = Get-Content -Path $File

# Regex pour adresse IP
$IPv4Regex = "(?<!\d\.)(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?!\d|\.\d)"

# Recherche si correspondance
$GcFile -match $IPv4Regex
```

## d. Script avec Foreach

```powershell
$File = "C:\Temp\file50.txt"
$GcFile = Get-Content -Path $File

# Regex pour adresse IP
$IPv4Regex = "(?<!\d\.)(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?!\d|\.\d)"

# Chercher les correspondances avec la regex
$Matches = [regex]::Matches($GcFile, $IPv4Regex)

# Afficher les correspondances
Foreach ($Match in $Matches)
{
    $Match.Value
}
```

## e. Script avec Foreach derrière un pipe

```powershell
$File = "C:\Temp\file50.txt"
$GcFile = Get-Content -Path $File

# Regex pour adresse IP
$IPv4Regex = "(?<!\d\.)(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?!\d|\.\d)"

[regex]::Matches($GcFile, $IPv4Regex) | ForEach-Object { $_.Value }
```
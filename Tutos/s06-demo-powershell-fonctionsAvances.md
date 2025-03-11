Objectif :
Besoin de créer un script pour insérer des adresses IP aléatoirement dans une chaîne de texte.

script CreationFichierAvecAdressesIP.ps1

```powershell
# Définition du chemin vers le fichier
$cheminFichier = "C:\temp\file50.txt"

# Taille du fichier en Ko
$tailleFichierKo = 10

# Nombre d'adresses IP viables et non-viables à générer
$nbIPViables = 10 # 15 octets
$nbIPNonViables = 10 # 11 octets

# -------------------------------------------------------------

# Calcul de la taille en octets
$tailleFichierOctets = $tailleFichierKo * 1024 - $nbIPViables*15 - $nbIPNonViables*11

Function GenererChaineAleatoire
{
    param ([int]$LongueurChaine=1000)

    $Caracteres = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()"
    $Chaine = ""
    For ($i = 0; $i -lt $LongueurChaine; $i++)
    {
        $Chaine += $Caracteres[(Get-Random -Minimum 0 -Maximum $Caracteres.Length)]
    }
    Return $Chaine
}

Function GenererAdresseIPv4
{
    $Octets = @()
    For ($i = 1; $i -le 4; $i++)
    {
        $Octet = Get-Random -Minimum 1 -Maximum 256
        $Octets += $Octet
    }
    Return ($Octets -join ".")
}

Function GenererAdresseIPNonViable
{
    $Octets = @()
    For ($j = 1; $j -le 3; $j++)
    {
        $Octet = Get-Random -Minimum 1 -Maximum 256
        $Octets += $Octet
    }
    Return ($Octets -join ".")
}

Function GenererTableauAdresseIP
{
    $Count = 0
    $TableauAdressesIP = @()
    While ($Count -lt $nbIPViables)
    {
        $TableauAdressesIP += GenererAdresseIPv4
        $Count++
    }
    $Count = 0
    While ($Count -lt $nbIPNonViables)
    {
        $TableauAdressesIP += GenererAdresseIPNonViable
        $Count++
    }
    Return $TableauAdressesIP
}

Function InsererChainesCaracteres
{
    param ([string]$Texte, [string[]]$TableauChaines)

    # Parcours du tableau de chaines
    Foreach ($Chaine in $TableauChaines)
    {
        # Recherche d'un index aléatoire dans le texte
        $Index = Get-Random -Minimum 0 -Maximum $Texte.Length

        # Insertion de la chaine à l'index aléatoire du texte
        $Texte = $Texte.Insert($Index, $Chaine)
    }

    Return $Texte
}

# Vérification d'existence du fichier, si non => création
If (-not (Test-Path $CheminFichier))
{
    New-Item -Path $CheminFichier -ItemType File | Out-Null
}

$ChainePourfichier = InsererChainesCaracteres -Texte $(GenererChaineAleatoire -LongueurChaine $tailleFichierOctets) -TableauChaines $(GenererTableauAdresseIP)
Set-Content -Value $ChainePourfichier -Path $cheminFichier -Force
```
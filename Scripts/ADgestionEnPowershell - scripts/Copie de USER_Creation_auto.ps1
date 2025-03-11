﻿######################################################################################################
#                                                                                                    #
#   Création USER automatiquement avec fichier (avec suppression protection contre la suppression)   #
#                                                                                                    #
######################################################################################################

$FilePath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

### Parametre(s) à modifier

$File = "$FilePath\USER_Creation_auto_Liste.txt"

### Main program

Clear-Host
If (-not(Get-Module -Name activedirectory))
{
    Import-Module activedirectory
}

$Users = Import-Csv -Path $File -Delimiter ";" -Header "Prenom","Nom","Tel","Service"
$ADUsers = Get-ADUser -Filter * -Properties *
$count = 1
Foreach ($User in $Users)
{
    Write-Progress -Activity "Création des utilisateurs dans l'OU" -Status "%effectué" -PercentComplete ($Count/$Users.Length*100)
    $Name              = "$($User.Nom) $($User.Prenom)"
    $DisplayName       = "$($User.Nom) $($User.Prenom)"
    $SamAccountName    = $($User.Prenom.substring(0,1).tolower()) + $($User.Nom.ToLower())
    $UserPrincipalName = (($User.prenom.substring(0,1).tolower() + $User.nom.ToLower()) + "@" + (Get-ADDomain).Forest)
    $GivenName         = $User.Prenom
    $Surname           = $User.Nom
    $OfficePhone       = $User.Tel
    $EmailAddress      = $UserPrincipalName
    $Path              = "ou=$($User.Service),ou=LabUtilisateurs,dc=lab,dc=lan"
    $Company           = "Ma Societe"
    $Department        = "$($User.Service)"
    
    If (($ADUsers | Where {$_.SamAccountName -eq $SamAccountName}) -eq $Null)
    {
        New-ADUser -Name $Name -DisplayName $DisplayName -SamAccountName $SamAccountName -UserPrincipalName $UserPrincipalName `        -GivenName $GivenName -Surname $Surname -OfficePhone $OfficePhone -EmailAddress $EmailAddress `        -Path $Path -AccountPassword (ConvertTo-SecureString -AsPlainText Azerty1* -Force) -Enabled $True `        -OtherAttributes @{Company = $Company;Department = $Department} -ChangePasswordAtLogon $True                Write-Host "Création du USER $SamAccountName" -ForegroundColor Green    }
    Else
    {
        Write-Host "Le USER $SamAccountName existe déjà" -ForegroundColor Black -BackgroundColor Yellow
    }
    $Count++
    sleep -Milliseconds 100
}
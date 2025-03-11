#########################################
#                                       #
#   Création GPO vide automatiquement   #
#                                       #
#########################################

### Parametre(s) à modifier

$GpoNameComputers = "Teledistribution-Logiciel-7Zip",`                    "Teledistribution-Logiciel-FirefoxESR"

$GpoNameUsers = "Teledistribution-Logiciel-Chrome",`                "Interface-Wallpaper",`                "Interface-WallpaperV2",`                "Securite-RestrictionAcces"

### Main program

Clear-Host
#Gpo Ordinateurs
Foreach ($Gpo in $GpoNameComputers)
{
  If (Get-GPO -Name "COMPUTER-$Gpo" -ErrorAction SilentlyContinue)  {        Write-Host "GPO COMPUTER-$Gpo déjà existente" -ForegroundColor Black -BackgroundColor Yellow  }  Else  {            New-GPO -Name "COMPUTER-$Gpo" -Comment "Gpo ORDINATEUR" -StarterGpoName "GPO Starter Computer" -ErrorAction SilentlyContinue        New-GPLink -Name "COMPUTER-$Gpo" -Target "OU=LabOrdinateurs,DC=lab,DC=lan" -LinkEnabled Yes -ErrorAction SilentlyContinue        Set-GPPermission -Name "COMPUTER-$Gpo" -TargetName "Authenticated Users" -TargetType User -PermissionLevel None  }
}

#Gpo Utilisateurs
Foreach ($Gpo in $GpoNameUsers)
{
  If (Get-GPO -Name "USER-$Gpo" -ErrorAction SilentlyContinue)  {        Write-Host "GPO USER-$Gpo déjà existente" -ForegroundColor Black -BackgroundColor Yellow  }  Else  {                New-GPO -Name "USER-$Gpo" -Comment "Gpo UTILISATEUR" -StarterGpoName "GPO Starter User" -ErrorAction SilentlyContinue        New-GPLink -Name "USER-$Gpo" -Target "OU=LabUtilisateurs,DC=lab,DC=lan" -LinkEnabled Yes -ErrorAction SilentlyContinue        Set-GPPermission -Name "USER-$Gpo" -TargetName "Authenticated Users" -TargetType User -PermissionLevel None
        Set-GPPermission -Name "USER-$Gpo" -TargetName "Domain Computers" -TargetType Group -PermissionLevel GpoApply
  }

}
Démo suite cours :
* Scripting Powershell (partie 2)

# 1. Commandes de base

## a. Throw

Permet de lever une exception

```powershell
function Start-Something
{
    throw "Bad thing happened"
}
```

## b. Try Catch

```powershell
Try
{
    # Bloc de code 1
    # S'éxecute ET qui peut échouer
}
Catch
{
    # Bloc de code qui s'éxecute si une erreur est détectée dans le Bloc de code 1
    $_.Exception.Message
}
Finally
{
    # Bloc de code qui s'éxecute TOUJOURS
}
```

# 2. Exemple 1 - Division par zéro

## a. Gestion avec If

```powershell
$Num1 = 10
$Num2 = 0

If ($Num2 -eq 0)
{
    Write-Warning "Division par zéro"
}
Else
{
    $Result = $Num1 / $Num2
    Write-Host "Résultat : $Result"
}
```

## b. Gestion avec Try catch

```powershell
$Num1 = 10
$Num2 = 0

Try
{
    $Result = $Num1 / $Num2
    Write-Host "Résultat : $Result"
}
Catch
{
    Write-warning "$($_.Exception.Message)"
}
```

# 3. Exemple 2 - Récupération adresse IP

## a. Gestion avec Foreach et If

Fichier IPAddress.txt :

```
8.8.8.8
8.8.4.4
194.158.122.10
80.10.246.2
80.10.246.129
199.60.103.225
194.158.122.15
212.27.40.240
142.250.74.227
142.250.201.164
212.27.40.241
109.0.66.10
109.0.66.20
52.84.177.237
91.121.61.147
87.98.149.171
1.1.1.1
1.0.0.1
208.67.222.222
208.67.220.220
```

```powershell
$IPAddresses = Get-Content -Path "C:\temp\IPAddress.txt"

Foreach ($IP in $IPAddresses)
{
	$PingResult = Test-Connection -ComputerName $IP -Count 1 -Quiet
	If ($PingResult)
	{
		Write-Host "Ping vers $IP => OK"
    }
    Else
    {
	    Write-Host "Ping vers $IP => NOK"
    }
}
```


## b. Gestion avec Foreach et try catch

```powershell
$IPAddresses = Get-Content -Path "C:\temp\IPAddress.txt"

Foreach ($IP in $IPAddresses)
{
	Try
	{
		Test-Connection -ComputerName $IP -Count 1 -ErrorAction Stop
        Write-Host "Ping vers $IP => OK"
    }
    Catch
    {
        Write-Host "Ping vers $IP => NOK -> $($_.Exception.Message)"
    }
}
```

function AfficherMessage
{
    [CmdletBinding()]

    param (
        [Parameter(Mandatory=$True)]
        [ValidateLength(5,10)]
        [String]$Nom,
        
        [Parameter(Mandatory=$True)]
        [ValidateSet('10', '15', '20', '25', '30')]
        [Int]$Age
    )
    
    Write-Host "Hello $Nom tu as bien $Age ans ?"
}

function Affichage
{
    param ([String]$Nom,[Int]$Age,[String]$LogFile)
    
    Try
    {
        $Res = AfficherMessage -Nom $Nom -Age $Age
        return $Res
    }
    Catch
    {
        # Log
        $GetDate = Get-Date -Format "yyyyMMdd-HHmmss"
        $UserName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
        $ErrorMessage = $_.Exception.Message
        $ErrorCode = $_.Exception.HResult
        $ErrorCodeHex = "{0:X}" -f [int]$ErrorCode
        $LogMessage = "$GetDate;$UserName;$errorCode (0x$ErrorCodeHex);$errorMessage"
        Add-Content -Path $LogFile -Value $LogMessage
    }
}

#Création des fichiers de log
Function CreationFichierLog
{
    # Parametres:
    # $LogFilePath : Chemin de l'emplacement du fichier de log, ex: '\\admin-srv2\dsi\_Ressources Communes\Powershell\Logs'
    # $LogFileName : Nom du fichier de log, ex: 'Test' <== nom sans extension de fichier log
    #
    # Les fichiers de log seront sous la forme %nom%-%date%-%heure%.txt
    #
    # Sortie:
    # Nom et path du fichier de log dans variable $LogFile

    Param([String]$LogFilePath,[String]$LogFileName)

    #Test existence repertoire des fichiers logs
    $Date = get-date -UFormat %Y%m%d-%Hh%M
    If ((Test-Path $LogFilePath) -eq $False)
    {
        #Création du repertoire de log s'il n'existe pas
        New-Item -Path $LogFilePath -ItemType Directory
    }
    #Test  existence fichier de logs
    If ((Test-Path "$LogFilePath\$Date-$LogFileName.txt") -eq $False)
    {
        #Création du fichier de log s'il n'existe pas
        New-Item -Path "$LogFilePath\$Date-$LogFileName.txt" -ItemType File | Out-Null
        $LogFile = "$LogFilePath\$Date-$LogFileName.txt"
    }
    Else
    {
        $Num = 2
        #Création du fichier de log sous la forme nom-v#
        While ((Test-Path "$LogFilePath\$Date-$LogFileName-v$Num.txt") -eq $True)
        {
            $Num += 1
        }
        New-Item -Path "$LogFilePath\$Date-$LogFileName-v$Num.txt" -ItemType File | Out-Null
        $LogFile = "$LogFilePath\$Date-$LogFileName-v$Num.txt"
    }
    $LogFile

}
############################################################################################
# Source Chocolatey profile
############################################################################################
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

############################################################################################
# Enable Vi mode and tweak PSReadLine options
############################################################################################
$PSReadLineOptions = @{
    BellStyle = "None"
    EditMode = "Vi"
}

Set-PSReadlineOption @PSReadLineOptions

############################################################################################
# Append local Python packages to PowerShell PATH
############################################################################################
$pythonPackagesPath = (get-item (python -m site --user-site)).Parent.FullName -Join "`n"
$pythonPackagesPath += "\Scripts"
$Env:PATH += ";$pythonPackagesPath"

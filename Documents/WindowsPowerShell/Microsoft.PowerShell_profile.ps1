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
# Define useful aliases
############################################################################################
Set-Alias vim nvim

############################################################################################
# Add tooling to PowerShell PATH
############################################################################################
# Python packages
$pythonPackagesPath = (get-item (python -m site --user-site)).Parent.FullName -Join "`n"
$pythonPackagesPath += "\Scripts"
$Env:PATH += ";$pythonPackagesPath"

# Neovim installed using Chocolatey
$Env:PATH += ";C:\Tools\neovim\Neovim\bin"

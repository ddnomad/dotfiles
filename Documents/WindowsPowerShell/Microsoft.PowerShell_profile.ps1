###############################################################################
# Chocolatey profile
###############################################################################
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

###############################################################################
# Enable Vi mode
###############################################################################
Set-PSReadlineOption -EditMode vi

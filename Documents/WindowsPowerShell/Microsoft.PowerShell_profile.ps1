###############################################################################
# Source Chocolatey profile
###############################################################################
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

###############################################################################
# Enable Vi mode and tweak PSReadLine options
###############################################################################
$PSReadLineOptions = @{
    BellStyle = "None"
    EditMode = "Vi"
}

Set-PSReadlineOption @PSReadLineOptions

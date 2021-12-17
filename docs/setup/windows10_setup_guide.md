Windows 10 Development Environment Setup
========================================

Step 1: Install Chocolatey
--------------------------
Run the following, step-by-step, from an elevated PowerShell instance:
``` powershell
# Download an installation script
Invoke-WebRequest -Uri "https://community.chocolatey.org/install.ps1" -OutFile "$HOME/Downloads/chocolatey_install.ps1"

# Check script signature status. Must print Status "Valid".
Get-AuthenticodeSignature -FilePath "$HOME/Downloads/chocolatey_install.ps1"

# Check certificate information. Make sure Thumbprint=83AC7D88C66CB8680BCE802E0F0F5C179722764B, CN="Chocolatey Software, Inc.".
(Get-AuthenticodeSignature -FilePath "$HOME/Downloads/chocolatey_install.ps1").SignerCertificate | Format-List

# Disable any limitations of a current execution policy for this Powershell process
Set-ExecutionPolicy Bypass -Scope Process

# Run the script
cd $HOME/Downloads; ./chocolatey_install.ps1
```

> **FIXME:** WARNING: Not setting tab completion: Profile file does not exist at
> 'C:\Users\$USER\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'.

Step 2: Installing Vim
----------------------
The main point of installing plain old Vim is to be able to access it from a regular PowerShell session. In the future,
this may change to NeoVim.

Download the installer from [here](https://www.vim.org) and make sure to pick "Full" install type during the installation
process.

Step 3: Generating GitHub SSH Key
---------------------------------
The process should be mostly similar to *Nix platforms. Run `ssh-keygen.exe` from a PowerShell session as `$USER`, go
through all steps and pick a decent passphrase. After the key is generated, add a basic SSH configuration file to
`$HOME/.ssh/config`:
```
Host github.com
    IdentityFile ~/.ssh/id_rsa_github_<USER>
```

Step 3: Integrating Dotfiles
----------------------------
From this point on, Chezmoi can be installed via `choco install chezmoi` and the integration steps should be similar
to all other platforms.

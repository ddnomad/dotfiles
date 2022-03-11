Windows 10 Development Environment Setup
========================================

Local Machine
-------------
### Step 1: Install Chocolatey
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

### Step 2: Installing Vim

The main point of installing plain old Vim is to be able to access it from a regular PowerShell session. In the future,
this may change to NeoVim.

Download the installer from [here](https://www.vim.org) and make sure to pick "Full" install type during the installation
process.

### Step 3: Generating GitHub SSH Key
The process should be mostly similar to *Nix platforms. Run `ssh-keygen.exe` from a PowerShell session as `$USER`, go
through all steps and pick a decent passphrase. After the key is generated, add a basic SSH configuration file to
`$HOME/.ssh/config`:
```
Host github.com
    IdentityFile ~/.ssh/id_rsa_github_<USER>
```

### Step 3: Integrating Dotfiles
Install Git (because default Git that is shipped with Windows does not support cloning via SSH; run from an elevated shell):
```
choco install git
```

From this point on, Chezmoi can be installed via `choco install chezmoi` (from an elevated shell); the integration steps should be similar
to all other platforms.

Remote Development Machine
--------------------------

### Step 1: Add Development User
Create a new user for development. Add it to `Administrators` group. You may need to reset the user's password immediately to
get around "You must change your password before logging on the first time" RDP error.

### Step 2: Set up SSH Server
> **FIXME**: Raw notes from https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse
In a privileged PowerShell instance:
``` powershell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# Make sure it's "Running"
Get-Service sshd

# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}

# Set PowerShell as a default shell for all SSH sessions
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force 
```

Edit SSHD configuration file via `notepad "$Env:ProgramData\ssh\sshd_config`:
```
PubkeyAuthentication yes
PasswordAuthentication no
```

Restart SSHD service:
```
Restart-Service sshd
```

Generate an SSH key on a local Windows machine and add it to `$Env:ProgramData\ssh\administrators_authorized_keys` on this
remote Windows machine. The process is mostly identical to the one on *Nix platforms. Do not forget to edit
`$HOME\.ssh\config` on the local machine to use a correct SSH key when connecting to this remote.

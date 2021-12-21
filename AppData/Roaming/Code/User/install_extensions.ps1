$VSCODE_EXTENSIONS = @'
golf1052.base16-generator
iocave.customize-ui
iocave.monkey-patch
ms-vscode-remote.remote-containers
ms-vscode-remote.remote-ssh
ms-vscode-remote.remote-ssh-edit
ms-vscode-remote.remote-wsl
ms-vscode-remote.vscode-remote-extensionpack
ms-vscode.powershell
usernamehw.errorlens
vscodevim.vim
'@

ForEach ($extension_id in $($VSCODE_EXTENSIONS -split "[\r\n]+")) {
    Write-Host "---(i) INFO: Installing VS Code extension: $extension_id"
    code --install-extension $extension_id
}

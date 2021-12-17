Dotfiles Monorepo
=================
![GitHub last commit](https://img.shields.io/github/last-commit/ddnomad/dotfiles)
![GitHub commit activity](https://img.shields.io/github/commit-activity/w/ddnomad/dotfiles)

This repository contains various configuration files and utility scripts dd relies on daily
for various things (mostly work and personal devepment though).

Supported Platforms
-------------------
The main focus is Arch Linux support, as that's what dd prefers for development 9 times out
of 10. MacOS and Windows are treated as a second class citizen, hence things will most probably
be broken, outdated or far from being ideal.

| Platform                                               | Chassis Types             | Support Tier                    |
| ------------------------------------------------------ | ---------------------     | ------------------------------- |
| [Arch Linux](https://www.archlinux.org)                | Laptop / Desktop / VMWare | Tier 1 - Actively maintained    |
| [MacOS](https://www.apple.com/macos)                   | Laptop / Desktop          | Tier 2 - Best Effort            |
| [Windows 10](https://en.wikipedia.org/wiki/Windows_10) | Desktop                   | Tier 3 - Low Effort / Barebones |

Prerequisites
-------------
### All Platforms
* [Chezmoi](https://www.chezmoi.io/)
* [Git](https://git-scm.com/)

### MacOS
* [Alacritty](https://github.com/alacritty/alacritty)
* [Homebrew](https://brew.sh)

### Linux / MacOS (Optional)
* [GNU Make](https://www.gnu.org/software/make/)

Fresh Host Setup
----------------
### OS-Specific Prerequisites
For Windows 10, see [setup guide](./docs/setup/windows10_setup_guide.md). Linux and MacOS setup
guides are not provided as of right now, mostly due to the fact it should be fairly trivial to
figure out as is.

### Integration
> **WARNING**: On Windows, `run_once_*.ps1` will execute in PowerShell bypassing a default
> security policy (i.e. `powershell.exe -NoLogo -ExecutionPolicy ByPass -File setup.ps1`).

Run the following to pull down the dotfiles: 
```
chezmoi init ddnomad --ssh
```

Preview what files will be copied (no changes will be made):
```
chezmoi cd && make dry
```

Apply all changes:
```
chezmoi cd && make apply
```

Please note, that files in `"$(chezmoi cd)"/root/` directory won't be applied
automatically. These should be copied manually as needed, as they fall outside
of `"${HOME}"` directory of a current user.

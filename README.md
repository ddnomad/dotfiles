Dotfiles Monorepo
=================
![GitHub last commit](https://img.shields.io/github/last-commit/ddnomad/dotfiles)
![GitHub commit activity](https://img.shields.io/github/commit-activity/w/ddnomad/dotfiles)

> **WARNING**: Migration to Chezmoi is still in progress and will probably take a while.
> Things change but slowly and extremely painfully. One day dd will actually clean up the mess.

Supported Platforms
-------------------
+ [Arch Linux](https://www.archlinux.org/) host (laptop / desktop)
+ [Arch Linux](https://www.archlinux.org/) guest (VMWare Workstation/Fusion)
+ [MacOS](https://www.apple.com/macos) host (laptop / desktop)

Prerequisites
-------------
The following tooling is required to integrate the dotfiles:
* [Chezmoi](https://www.chezmoi.io/)
* [Git](https://git-scm.com/)
* [GNU Make](https://www.gnu.org/software/make/)

Fresh Host Setup
----------------
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

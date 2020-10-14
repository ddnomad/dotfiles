Dotfiles Monorepo
=================
![GitHub last commit](https://img.shields.io/github/last-commit/ddnomad/dotfiles)
![GitHub commit activity](https://img.shields.io/github/commit-activity/w/ddnomad/dotfiles)

> **NOTE**: Work in progress. Stuff's being merged from different places, templating
> support is being implemented etc. Stuff breaks, may be missing or unstable. Such is
> life.

This repository contains my personal dotfiles that aim to support the following
OS/environments:

+ [Arch Linux](https://www.archlinux.org/) host machines (laptops / desktops)
+ [Arch Linux](https://www.archlinux.org/) guest VMs (VMWare Workstation/Fusion)
+ [MacOS](https://www.apple.com/macos) host machines (laptops / desktops)
+ [WSL v2](https://docs.microsoft.com/en-us/windows/wsl/install-win10) environment
  on Windows 10 (low priority)

Currently the support is best effort and issues are fixed irregularly (mostly
as I switch between different machines for work / personal matters).

## General Information
[YADM](https://github.com/TheLocehiliosan/yadm) is used for dotfiles management.

## Installation Notes
* To prevent esoteric bs happening with i3vm tiles focusing when using
`unclutter`, its fork should be installed `unclutter-xfixes-git`

## Documentation
* [NeoVim Usage Notes](./docs/neovim_usage_notes.md)

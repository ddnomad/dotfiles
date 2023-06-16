# Arch Linux Installation on MacBook Pro 12,1 (Retina, 13-inch, Early 2015)

## Hardware Support
> The bane of Linux user's existence, also knows as a fearful [Broadcom](https://www.broadcom.com/) corporation, strikes again.


## Base Installation

> NOTE: This guide assumes that the SSD on the laptop was fully ### Suggested Topicssecurely wiped beforehand. It is advisable to re-install MacOS Monterey after the wipe to be able to use Apple's native bootloader with `systemd-boot`.

Boot from Ventoy Grub 2 mode (regular boot option does not work). Loosely follow [Arch Wiki installation guide](https://wiki.archlinux.org/title/installation_guide), [Arch Linux full disk encryption guide](https://wiki.archlinux.org/title/dm-crypt/Encrypting_an_entire_system), [Arch Wiki Mac guide](https://wiki.archlinux.org/title/Mac) and [Arch Wiki MacBook 12.1 guide](https://wiki.archlinux.org/title/User:Elinux/MacBook_Pro_12,1) if the steps below do not work as expected.

Connect to WiFi using `iwctl`:

```shell
# Drop into iwctl shell
iwctl

station wlan0 scan

# Should list all available networks
station wlan0 get-networks

# Replace NETWORK_NAME with the SSID (name) of the network to connect to, this will prompt for a password
station wlan0 connect NETWORK_NAME
```

Verify the laptop is connected to the internet:

```shell
ping google.com
```

This guide will be using "LVM on LUKS" approach for a full disk encryption, which is different from [LUKS on LVM](https://gist.github.com/ddnomad/57c2ed9cc8372d0079fc280e7459bbeb) dd is used to. The reasoning is mostly simplicity and the fact that the laptop cannot be used with 2 or more storage drives anyway.

Verify that OS drive contains only 2 partitions (should be the case with default MacOS install) by running `lsblk` command, which should produce output similar to below:

```shell
NAME   MAJ:MIN RM    SIZE RO TYPE MOUNTPOINTS
loop0    7:0    0  710.1M  1 loop /run/archiso/airootfs
sda      8:0    0  465.9G  0 disk
├─sda1   8:1    0    200M  0 part
├─sda2   8:2    0  465.6G  0 part
...
```

Wipe and re-create the second partition with `fdisk` by first getting into interactive shell with `fdisk /dev/sda`, then going through the flow below:

1. Press `d` key followed by Enter key (this will prompt for a number of a partition to delete)
2. Press `2` key followed by Enter key (we choose and delete the second partition, which corresponds to `/dev/sda2`)
3. Press `n` key followed by Enter key (this start a creation of a new partition)
4. Keep pressing Enter key to use default options during partition setup
5. Press `w` key followed by Enter key to write the changes

Create LUKS container partition:

```shell
# This will ask for a confirmation and warn that all data will be overwritten. Type in "YES", after which
# you will be prompted for an encryption passphrase. Choose a good passphrase and type it in (you will have
# to type it in again).
cryptsetup -y -v luksFormat /dev/sda2

# This will prompt for the same passphrase again
cryptsetup open /dev/sda2 cryptlvm
```

Create logical volumes:

```shell
# Create a physical volume on top of LUKS container
pvcreate /dev/mapper/cryptlvm

# Create a volume group
vgcreate CryptLVM /dev/mapper/cryptlvm

# Create logical volumes inside the group
lvcreate -L 16G CryptLVM -n swap
lvcreate -l 100%FREE CryptLVM -n root

# Following a tip on Arch Wiki to allow for e2scrub to function (see https://man.archlinux.org/man/e2scrub.8).
# This will warn about data loss and ask for a confirmation. Confirm the action.
lvreduce -L -256M CryptLVM/root
```

Create filesystems:

```shell
mkfs.ext4 /dev/CryptLVM/root
mkswap /dev/CryptLVM/swap
```

Mount the filesystems:

```shell
mount /dev/CryptLVM/root /mnt
mount --mkdir /dev/sda1 /mnt/boot
swapon /dev/CryptLVM/swap
```

Update list of package mirrors with `reflector`:

```shell
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
```

Install the base system:

```shell
pacstrap -K /mnt base linux linux-firmware intel-ucode lvm2 vim man-db man-pages networkmanager sudo which

# TODO: broadcom-wl ???
```

Generate `fstab` file:

```shell
genfstab -U /mnt >> /mnt/etc/fstab
```

Change root into the new installation:

```shell
arch-chroot /mnt
```

Set the time zone:

```shell
# Replace REGION and CITY with the actual region and city of your time zone
ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime

# Generate /etc/adjtime
hwclock --systohc
```

Uncomment necessary locales in `/etc/locale.gen` (e.g. `en_US.UTF-8 UTF-8` and `en_HK.UTF-8 UTF-8`). Run `local-gen` to generate locales.

Create `locale.conf` file with the following contents:

```shell
LANG=en_US.UTF-8
```

Edit `/etc/hostname` to contain a host name you want to use for this laptop.

Set `root` password and create additional users:

```shell
# This will prompt for a new password for root user
passwd

# Create an additional user
groupadd sudo
useradd -m -G sudo -s /usr/bin/bash ddnomad

# This will prompt for a new password for ddnomad user
passwd ddnomad
```

Uncomment a line that starts with `%sudo` in `/etc/sudoers` (to allow users in group `sudo` to use `sudo`):

```shell
chmod +w /etc/sudoers
$EDITOR /etc/sudoers
chmod -w /etc/sudoers
```

Edit `/etc/mkinitcpio.conf`, make sure that line that starts with `HOOKS=(` looks like the following:

```shell
...
HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)
...
```

Generate `initramfs`:

```shell
mkinitcpio -P
```

Install `systemd-boot` onto the boot partition:

```shell
bootctl --path=/boot install
```

Modify `systemd-boot` configuration file in `/boot/loader/loader.conf`:

```shell
console-mode keep
default arch.conf
editor no
timeout 3
```

Get a persistent UUID for a LUKS container partition `/dev/sda2` by running `blkid`. The value should be specified as a value of `UUID` parameter in the output (without quotes), e.g. `/dev/sda2: UUID="XXXX"` (the value is `XXXX` here).

Create Arch Linux boot entry in `/boot/loader/entries/arch.conf` with the following contents (replace `XXXX` with the actual persistent UUID retrieved above):

```shell
title Arch Linux
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options root="LABEL=arch_os" cryptdevice=UUID=XXXX:cryptlvm root=/dev/CryptLVM/root rw
```

Exit from `chroot` and reboot:

```shell
exit
umount -R /mnt
reboot
```

DE Installation & Post Install Setup
------------------------------------

Once booted into the OS for the first time and logged in as a non-root user in `sudo` group, enable and start Network Manager. Then connect to the WiFi network:

```shell
sudo systemctl enable --now NetworkManager

# Lists available WiFi networks
nmcli dev wifi list

# Connect to a network with SSID equals to NETWORK_NAME. This will prompt for a password from the WiFi network.
sudo nmcli dev wifi connect NETWORK_NAME -a
```

Install Gnome:

```shell
# Update the system just in case first
sudo pacman -Syu

# This will ask for input, just press enter to accept the default choice
sudo pacman -S gnome gnome-tweaks

# Enable display manager to start Gnome on boot
sudo systemctl enable --now gdm.service
```

> See wireless issues doc for details on wireless card saga (TODO)

Basic things:
* `sudo pacman -S firefox git`
* Created `id_rsa_github` key pair
* Create `~/.ssh/config` file with configuration for `github.com`

Install `paru` following the official guide, basically:

```shell
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru

# This will fail at first, do 'rustup default nightly'
makepkg -si
```

Install a bunch of useful apps:

```shell
paru -S 1password obsidian signal-desktop telegram-desktop-bin visual-studio-code-bin 
```

Enable fractional scaling for all users:

```shell
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
```

Create the following files:

```shell
# /etc/dconf/profile/user
user-db:user
system-db:local
```

```shell
# /etc/dconf/db/local.d/00-hidpi
[org/gnome/mutter]
experimental-features=['scale-monitor-framebuffer']
```

```shell
# /etc/dconf/db/locks/hidpi
/org/gnome/mutter/experimental-features
```

Run `dconf update`

Create `~/.bash_profile`:
```
# This if for Firefox to properly scale
export MOZ_ENABLE_WAYLAND=1
```

Create `~/.config/electron-flags.conf`:

```shell
--enable-features=WaylandWindowDecorations
--ozone-platform-hint=auto
```

Copy to apply it for VS Code:
```shell
cp ~/.config/electron-flags.conf ~/.config/code-flags.conf
```

Reboot to fully apply the settings.

Fix [MIME type fuckery](https://github.com/microsoft/vscode/issues/41037), as default is broken:
```
[ddnomad@empyrean ~]$ cat ~/.config/mimeapps.list 
[Default Applications]
inode/directory=org.gnome.Nautilus.desktop
```

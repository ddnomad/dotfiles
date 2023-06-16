# MacBook Pro 12,1 (Retina, 13-inch, Early 2015) Wireless Card Issues on Linux

> TODO: Pretty

What Works?
-----------

Known not properly working MacBook 12.1 NIC (use the script and unit as a workaround):
```
Model number: BCM943602CS
```

Known and confirmed working NIC:
```
Model number: BCM94360CS

lspci output:
03:00.0 Network controller: Broadcom Inc. and subsidiaries BCM4360 802.11ac Wireless Network Adapter (rev 03)
```

How to Fix
----------

* Swap the NIC
* Sideload `pahole`, `pacman -U pahole...`
* Sideload `gc`, `gcc`, `guile`, `libisl`, `make`, `patch` and install with `pacman -U`
* Sideload `broadcom-wl-dkms` and install with `pacman -U`

```shell
sudo rmmod b43 b43legacy bcm43xx bcma brcm80211 brcmfmac brcmsmac ssb tg3 wl
sudo modprobe wl
```

Workaround for Bad NIC
----------------------

```shell
# brcmfmac-sleep.service
[Unit]
Description=Unload/load brcmfmac on sleep/wake to avoid sadness
Before=sleep.target
StopWhenUnneeded=yes

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/broadcomctl stop
ExecStop=/usr/bin/broadcomctl start

[Install]
WantedBy=sleep.target
```

```shell
#!/usr/bin/bash
# broadcomctl

start_service() {
    echo "Adding brcmfmac"
    modprobe brcmfmac || exit -1
    sleep 3
    echo "Turning radio on"
    nmcli radio wifi on || exit -2
}

stop_service() {
    echo "Turning radio off"
    nmcli radio wifi off || exit -1
    sleep 3
    echo "Removing brcmfmac"
    modprobe -rf brcmfmac || exit -2
}

case $1 in
    start)
        start_service $1
        ;;
    stop)
        stop_service $1
        ;;
    restart)
        stop_service $1
        sleep 3
        start_service $1
        ;;
esac

exit 0
```

# Setting up NixOS

## Prerequisites
* easygen

## Format partitions (using sgdisk)
source: https://suntong.github.io/blogs/2015/12/26/creating-gpt-partitions-easily-on-the-command-line/

```sh
~/go/bin/easygen -tf ~/go/src/github.com/go-easygen/easygen/test/sgdisk.tmpl sgdisk.yaml > create-partitions.sh
```

## Initializing partitions (using mkfs)

## Mount root and boot partitions

```sh
mount /dev/disk/by-label/nixos /mnt
mount /dev/sda1 /mnt/boot
```

# TODOs
* maybe use just: https://github.com/casey/just
* use LVM

lvmdiskscan

pvcreate /dev/nvme01n1 /dev/nvme1n1
pvdisplay

vgcreate Data /dev/nvme0n1 /dev/nvme1n1
vgdisplay

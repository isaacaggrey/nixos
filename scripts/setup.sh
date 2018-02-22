#! /usr/bin/env nix-shell
#! nix-shell -i bash -p git go
set -x

# setup partitions
sgdisk --zap-all /dev/nvme0n1
sgdisk --new=0:0:+256M --typecode=0:ef00 --change-name=0:"boot" /dev/nvme0n1
sgdisk --new=0:0:0     --typecode=0:8300 --change-name=0:"data1" /dev/nvme0n1
partprobe /dev/nvme0n1

sgdisk --zap-all /dev/nvme1n1
sgdisk --new=0:0:0 --typecode=0:8300 --change-name=0:"data2" /dev/nvme1n1
partprobe /dev/nvme1n1

# configure LVM
pvcreate --force --force --yes /dev/nvme0n1p2 /dev/nvme1n1p1

vgcreate vg0 /dev/nvme0n1p2 /dev/nvme1n1p1

lvcreate --name swap vg0 -L 4G
lvcreate --name root vg0 --extents 100%FREE

mkfs.vfat -n BOOT /dev/nvme0n1p1
mkswap --label swap /dev/vg0/swap
mkfs.ext4 -L nixos /dev/vg0/root

mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

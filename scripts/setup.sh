#! /usr/bin/env nix-shell
#! nix-shell -i bash -p git go

git clone https://github.com/isaacaggrey/nixos.git

# configure easygen
export GOPATH=`pwd`
go get github.com/go-easygen/easygen/...

# configure LVM
lvmdiskscan

pvcreate /dev/nvme01n1 /dev/nvme1n1
pvdisplay

vgcreate Data /dev/nvme0n1 /dev/nvme1n1
vgdisplay

# generate partitions
easygen src/github.com/go-easygen/easygen/test/sgdisk.tmpl nixos/sgdisk-work.yaml > create-partitions.sh

./create-partitions.sh

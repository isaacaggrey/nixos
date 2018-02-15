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

##
# modify configuration.nix
* set `boot.loader.systemd-boot.enable = true;`
* comment out `boot.loader.grub` settings

```nix
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;

  # Enable the OpenSSH server.
  services.sshd.enable = true;

  system.stateVersion = "17.09";
}
```

# TODOs
* maybe use just: https://github.com/casey/just
* use LVM

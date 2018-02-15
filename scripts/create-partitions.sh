 # format /dev/sda as GPT, GUID Partition Table
 sgdisk -Z /dev/sda

 sgdisk -n 0:0:+256M -t 0:ef00 -c 0:"boot" /dev/sda
 sgdisk -n 0:0:+4G   -t 0:8200 -c 0:"swap" /dev/sda
 sgdisk -n 0:0:0     -t 0:8300 -c 0:"data" /dev/sda

 sgdisk -p /dev/sda

 # inform the OS of partition table changes
 partprobe /dev/sda
 fdisk -l /dev/sda

#!/bin/bash

install_mdadm() {
     yum -y install mdadm
}

configure_raid10() {
     mdadm --create --verbose /dev/md100 --level=10 --raid-devices=6 /dev/sd[b-g]
}

create_fs() {
     mkfs.ext4 /dev/md100
     mkdir -p /mnt/raid
     chmod 777 /mnt/raid
     bash -c "echo /dev/md100 /mnt/raid ext4  rw,user,exec 0 0 >> /etc/fstab"
     bash -c "echo chmod 777 /mnt/raid >> /etc/rc.local"
     mount /mnt/raid
     chmod 777 /mnt/raid
}

main() {
  install_mdadm
  configure_raid10
  create_fs
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"

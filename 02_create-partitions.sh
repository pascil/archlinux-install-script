#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

mkfs.vfat -F 32 -n EFI ${EFI_PARTITION}
mkfs.ext4 -L BOOT ${BOOT_PARTITION}
mkfs.btrfs -f -L ROOT ${ROOT_PARTITION}
mkfs.btrfs -f -L HOME ${HOME_PARTITION}


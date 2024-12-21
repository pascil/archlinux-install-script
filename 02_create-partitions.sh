#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

mkfs.fat -F 32 -n EFI ${EFI_PARTITION}
mkfs.ext4 -L BOOT ${BOOT_PARTITION}
mkfs.btrfs -L ROOT ${ROOT_PARTITION}
mkfs.btrfs -L HOME ${HOME_PARTITION}


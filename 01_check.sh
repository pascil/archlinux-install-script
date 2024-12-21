#!/usr/bin/env bash

set -x #echo on

echo -ne "
Check variables
"

if [[ -z ${BOOT_PARTITION+y} ]]; then
    echo "BOOT_PARTITION is not defined"
    exit 1
else
    echo "BOOT_PARTITION  ${BOOT_PARTITION}"
fi

if [[ -z ${EFI_PARTITION+y} ]]; then
    echo "EFI_PARTITION is not defined"
    exit 1
else
    echo "EFI_PARTITION  ${EFI_PARTITION}"
fi

if [[ -z ${ROOT_PARTITION+y} ]]; then
    echo "ROOT_PARTITION is not defined"
    exit 1
else
    echo "ROOT_PARTITION ${ROOT_PARTITION}"
fi

if [[ -z ${HOME_PARTITION+y} ]]; then
    echo "HOME_PARTITION is not defined"
    exit 1
else
    echo "HOME_PARTITION ${HOME_PARTITION}"
fi

if [[ -z ${INST_HOSTNAME+y} ]]; then
    echo "INST_HOSTNAME is not defined"
    exit 1
else
    echo "INST_HOSTNAME ${INST_HOSTNAME}"
fi

if [[ -z ${USER+y} ]]; then
    echo "USER is not defined"
    exit 1
else
    echo "USER ${USER}"
fi

if [[ -z ${LOCALE+y} ]]; then
    echo "LOCALE is not defined"
    exit 1
else
    echo "LOCALE ${LOCALE}"
fi

if [[ -z ${KEYMAP+y} ]]; then
    echo "KEYMAP is not defined"
    exit 1
else
    echo "KEYMAP ${KEYMAP}"
fi

if [[ -z ${CPU+y} ]]; then
    echo "CPU is not defined"
    exit 1
else
    echo "CPU ${CPU}"
fi

if [[ -z ${TIMEZONE+y} ]]; then
    echo "TIMEZONE is not defined"
    exit 1
else
    echo "TIMEZONE ${TIMEZONE}"
fi

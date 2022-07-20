#!/usr/bin/env bash

set -x #echo on

echo -ne "
Check variables
"

if [[ -z ${EFI_PARTITION+y} ]]; then
    echo "EFI_PARTITION is not defined"
    exit 1
else
    echo "EFI_PARTITION  ${EFI_PARTITION}"
fi

if [[ -z ${SWAP_PARTITION+y} ]]; then
    echo "SWAP_PARTITION is not defined"
    exit 1
else
    echo "SWAP_PARTITION ${SWAP_PARTITION}"
fi

if [[ -z ${ROOT_PARTITION+y} ]]; then
    echo "ROOT_PARTITION is not defined"
    exit 1
else
    echo "ROOT_PARTITION ${ROOT_PARTITION}"
fi

if [[ -z ${DATA_PARTITION+y} ]]; then
    echo "DATA_PARTITION is not defined"
    exit 1
else
    echo "DATA_PARTITION ${DATA_PARTITION}"
fi

if [[ -z ${INST_HOSTNAME+y} ]]; then
    echo "INST_HOSTNAME is not defined"
    exit 1
else
    echo "INST_HOSTNAME ${INST_HOSTNAME}"
fi


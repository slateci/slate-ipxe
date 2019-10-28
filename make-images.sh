#!/bin/bash

set -e

echo "add iPXE submodule, reset any changes, and update"
git submodule add https://git.ipxe.org/ipxe.git || echo "Already exists, continuing..."
pushd ipxe
git reset --hard
git pull origin
popd

echo "pulling iPXE bootstrap script"
curl https://fm-test.chpc.utah.edu/unattended/iPXE?bootstrap=1 --output slate.ipxe

pushd ipxe
pushd src

#make EMBED=../slate.ipxe bin/ipxe.usb
make clean
echo "Making EFI image"
make EMBED=../../slate.ipxe bin-x86_64-efi/ipxe.efi
echo "Making BIOS USB image"
make EMBED=../../slate.ipxe bin/ipxe.usb
echo "Making ISO image"
make EMBED=../../slate.ipxe bin/ipxe.iso

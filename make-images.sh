#!/bin/bash

set -e

echo "add iPXE submodule, reset any changes, and update"
git submodule add https://git.ipxe.org/ipxe.git || echo "Already exists, continuing..."
pushd ipxe
git reset --hard
git pull origin
popd

pushd ipxe
pushd src

make clean
echo "Making EFI image"
make EMBED=../../slate.ipxe bin-x86_64-efi/ipxe.efi
echo "Making EFI USB image"
make EMBED=../../slate.ipxe bin-x86_64-efi/ipxe.usb
echo "Making BIOS USB image"
make EMBED=../../slate.ipxe bin/ipxe.usb
echo "Making ISO image"
make EMBED=../../slate.ipxe bin/ipxe.iso

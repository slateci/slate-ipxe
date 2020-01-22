#!/bin/bash

set -e

echo "Updating submodules..."
git submodule update

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

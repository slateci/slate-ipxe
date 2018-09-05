#!/bin/bash

set -e

echo "add iPXE submodule, reset any changes, and update"
git submodule add git://git.ipxe.org/ipxe.git || echo "Already exists, continuing..."
pushd ipxe
git reset --hard
git pull origin
popd

pushd ipxe
echo "Enable iPXE Options used by SLATE"
pushd src
pushd config
sed -i 's/\/\/\#define\ VLAN_CMD/\#define\ VLAN_CMD/' general.h
sed -i 's/\/\/\#define\ PING_CMD/\#define\ PING_CMD/' general.h
sed -i 's/\/\/\#define\ NSLOOKUP_CMD/\#define\ NSLOOKUP_CMD/' general.h
popd
#make EMBED=../slate.ipxe bin/ipxe.usb
make clean
echo "Making EFI image"
make EMBED=../../slate.ipxe bin-x86_64-efi/ipxe.efi
echo "Making BIOS USB image"
make EMBED=../../slate.ipxe bin/ipxe.usb
echo "Making ISO image"
make EMBED=../../slate.ipxe bin/ipxe.iso

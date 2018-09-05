#!/bin/bash
ISOFILE=ipxe/src/bin/ipxe.iso
echo "removing old config"
virsh destroy ipxe
virsh undefine ipxe
echo "starting new config.." 
virt-install --cdrom $ISOFILE --name ipxe --memory 2048 --vcpus 1 --console pty,target_type=serial --disk=none --os-variant linux --force


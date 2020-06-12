#!/bin/bash -eux

# Install dkms for guest additions
# installed during installation
# apt-get install -y build-essential dkms linux-headers-$(uname -r) gcc make perl

# Install the VirtualBox guest additions
mkdir -p /mnt/vbox
mount -o loop ~/VBoxGuest*.iso /mnt/vbox

yes|sh /mnt/vbox/VBoxLinuxAdditions.run \
        || echo "VBoxLinuxAdditions.run exited $? and is suppressed." \
            "For more read https://www.virtualbox.org/ticket/12479";

umount /mnt/vbox

#Cleanup VirtualBoxœ
rm -rf /mnt/vbox ~/VBoxGuest*.iso

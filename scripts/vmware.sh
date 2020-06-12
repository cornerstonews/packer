#!/bin/bash -eux

## Install VMWare Guest utils with apt
apt-get install -y open-vm-tools;
mkdir /mnt/hgfs;
#echo -n ".host:/ /mnt/hgfs vmhgfs rw,ttl=1,uid=my_uid,gid=my_gid,nobootwait 0 0" >> /etc/fstab
systemctl enable open-vm-tools
systemctl start open-vm-tools


# ### Install VMWare Guest utils from ISO
# 
# ## Install dependencies
# #apt-get instll -y binutils
# 
# ## Mount setup file
# mkdir -p /mnt/cdrom
# mount -o loop ~/linux.iso /mnt/cdrom
# 
# ## Extract setup file
# cd /tmp
# tar zxf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/
# 
# ## Unmount setup file
# umount /mnt/cdrom
# rm -rf ~/linux.iso /mnt/cdrom
# 
# ## Execute setup
# /tmp/vmware-tools-distrib/vmware-install.pl --default
# 
# ## Clean
# rm -fr /tmp/vmware-tools-distrib

#!/bin/bash -eux
echo "Setting up vagrant..."

### Create vagrant user
adduser --disabled-password --shell /bin/bash --gecos '' vagrant
echo "vagrant:vagrant" | chpasswd
usermod -aG sudo vagrant

### Set up password-less sudo for the vagrant user
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/vagrant;
chmod 440 /etc/sudoers.d/vagrant;

# Store build time
date > /etc/vagrant_box_build_time

HOME_DIR=$(eval echo ~vagrant)

pubkey_url="https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub";
mkdir -p $HOME_DIR/.ssh;
if command -v wget >/dev/null 2>&1; then
    wget --no-check-certificate "$pubkey_url" -O $HOME_DIR/.ssh/authorized_keys;
elif command -v curl >/dev/null 2>&1; then
    curl --insecure --location "$pubkey_url" > $HOME_DIR/.ssh/authorized_keys;
else
    echo "Cannot download vagrant public key";
    exit 1;
fi
chown -R vagrant $HOME_DIR/.ssh;
chmod -R go-rwsx $HOME_DIR/.ssh;

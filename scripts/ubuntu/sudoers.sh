#!/bin/bash -eux

### Set sudoers users to not ask for password by default
### Do not turn this on unless you want all sudoer users to have password-less sudo
#sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers;

### Set up password-less sudo for the ubuntu user
echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/ubuntu;
chmod 440 /etc/sudoers.d/ubuntu;

#!/bin/bash

# requirement for qemu/kvm
sudo virsh net-autostart default

# requirement for gpg
gpgconf --reload gpg-agent

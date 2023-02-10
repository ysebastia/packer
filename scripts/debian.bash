#!/bin/bash
# with vagrant-libvert, netcard is on pci5 (ens5 device)
sed -i -e 's/ens3/ens5/g' /etc/network/interfaces
exit 0

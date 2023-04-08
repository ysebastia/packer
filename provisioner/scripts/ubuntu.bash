#!/bin/bash
cloud-init status --wait
cloud-init clean --logs --machine-id
truncate -s 0 /etc/machine-id
exit 0

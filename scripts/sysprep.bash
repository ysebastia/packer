#!/bin/bash

BOX_NAME=$1
OPERATION=$2

virt-sysprep --operations "${OPERATION}" -a "artifacts/${BOX_NAME}/${BOX_NAME}"
virt-sparsify --in-place "artifacts/${BOX_NAME}/${BOX_NAME}"

exit 0

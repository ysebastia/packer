#!/bin/bash

BOX_NAME=$1
BOX_VERSION=$2
BOX_FILE=$3

jq -n \
  --monochrome-output \
  --arg name "$BOX_NAME" \
  --arg version "$BOX_VERSION" \
  --arg file "$(basename $BOX_FILE)" \
  --arg checksum "$(sha256sum $BOX_FILE | cut -f 1 -d " ")" \
  '{
  name: $name,
  "versions": [
    {
      version: $version,
      "providers": [
        {
          "name": "libvirt",
          "url": $file,
          "checksum_type": "sha256",
          "checksum": $checksum
        }
      ]
    }
  ]
}
'

exit 0

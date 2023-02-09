all: centos debian

centos:
	rm -rf artifacts/centos9s
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 packer build centos.pkr.hcl

debian:
	rm -rf artifacts/debian
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 packer build debian.pkr.hcl

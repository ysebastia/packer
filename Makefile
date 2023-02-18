all: centos debian

centos: centos_build

debian: debian_build

centos_build:
	rm -rf artifacts/centos9s
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 packer build centos.pkr.hcl

centos_install:
	cd artifacts/centos9s && vagrant box add metadata.json --force

debian_build:
	rm -rf artifacts/debian11
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 packer build debian.pkr.hcl

vagrant_prune:
	vargrant box prune

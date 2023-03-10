
all: alma centos debian

alma: alma_build alma_install

centos: centos_build centos_install

debian: debian_build debian_install

alma_build:
	rm -rf artifacts/alma9
	CHECKPOINT_DISABLE=1 packer build alma.pkr.hcl

alma_install:
	cd artifacts/alma9 && vagrant box add metadata.json --force

centos_build:
	rm -rf artifacts/centos9s
	CHECKPOINT_DISABLE=1 packer build centos.pkr.hcl

centos_install:
	cd artifacts/centos9s && vagrant box add metadata.json --force

debian_build:
	rm -rf artifacts/debian11
	CHECKPOINT_DISABLE=1 packer build debian.pkr.hcl
	
debian_install:
	cd artifacts/debian11 && vagrant box add metadata.json --force

vagrant_prune:
	vargrant box prune

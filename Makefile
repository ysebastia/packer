all: alma debian

alma: alma_build alma_install

debian: debian_build debian_install

alma_build:
	rm -rf artifacts/alma9
	CHECKPOINT_DISABLE=1 packer build alma.pkr.hcl

alma_install:
	cd artifacts/alma9 && vagrant box add metadata.json --force

debian_build:
	rm -rf artifacts/debian11
	CHECKPOINT_DISABLE=1 packer build -var-file="debian.pkrvars.hcl" debian.pkr.hcl
	
debian_install:
	cd artifacts/debian11 && vagrant box add metadata.json --force

vagrant_prune:
	vargrant box prune

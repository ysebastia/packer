all: alma debian

alma: alma8 alma9

alma8: alma8_build alma8_install

alma9: alma9_build alma9_install

debian: debian_build debian_install

alma8_build:
	rm -rf artifacts/alma8
	CHECKPOINT_DISABLE=1 packer build -var-file="alma8.pkrvars.hcl" vagrant.pkr.hcl

alma8_install:
	cd artifacts/alma8 && vagrant box add metadata.json --force

alma9_build:
	rm -rf artifacts/alma9
	CHECKPOINT_DISABLE=1 packer build -var-file="alma9.pkrvars.hcl" vagrant.pkr.hcl

alma9_install:
	cd artifacts/alma9 && vagrant box add metadata.json --force

debian_build:
	rm -rf artifacts/debian11
	CHECKPOINT_DISABLE=1 packer build -var-file="debian.pkrvars.hcl" vagrant.pkr.hcl
	
debian_install:
	cd artifacts/debian11 && vagrant box add metadata.json --force

vagrant_prune:
	vargrant box prune

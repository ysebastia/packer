all: alma debian

alma: alma9

alma9: alma9_build alma9_install

debian: debian12

debian12: debian12_build debian12_install

debian12_up:
	cd vagrant/debian12 && vagrant up

debian12_ssh:
	cd vagrant/debian12 && vagrant ssh

debian12_destroy:
	cd vagrant/debian12 && vagrant destroy

alma9_build:
	rm -rf artifacts/alma9
	CHECKPOINT_DISABLE=1 packer build -var-file="machines/alma9.pkrvars.hcl" vagrant.pkr.hcl

alma9_install:
	cd artifacts/alma9 && vagrant box add metadata.json --force

alma9_up:
	cd vagrant/alma9 && vagrant up

alma9_ssh:
	cd vagrant/alma9 && vagrant ssh

alma9_destroy:
	cd vagrant/alma9 && vagrant destroy

debian12_build:
	rm -rf artifacts/debian12
	CHECKPOINT_DISABLE=1 packer build -var-file="machines/debian12.pkrvars.hcl" vagrant.pkr.hcl
	
debian12_install:
	cd artifacts/debian12 && vagrant box add metadata.json --force

vagrant_prune:
	vargrant box prune

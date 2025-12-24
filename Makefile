all: alma debian

alma: alma9

alma9: alma9_build alma9_install

debian: debian13

debian13: debian13_build debian13_install

debian13_up:
	cd vagrant/debian13 && vagrant up

debian13_ssh:
	cd vagrant/debian13 && vagrant ssh

debian13_destroy:
	cd vagrant/debian13 && vagrant destroy

alma9_build:
	rm -rf artifacts/alma9
	CHECKPOINT_DISABLE=1 n/packer build -var-file="machines/alma9.pkrvars.hcl" vagrant.pkr.hcl

alma9_install:
	cd artifacts/alma9 && vagrant box add metadata.json --force

alma9_up:
	cd vagrant/alma9 && vagrant up

alma9_ssh:
	cd vagrant/alma9 && vagrant ssh

alma9_destroy:
	cd vagrant/alma9 && vagrant destroy

debian13_build:
	rm -rf artifacts/debian13
	CHECKPOINT_DISABLE=1 /usr/bin/packer build -var-file="machines/debian13.pkrvars.hcl" vagrant.pkr.hcl
	
debian13_install:
	cd artifacts/debian13 && vagrant box add metadata.json --force

vagrant_prune:
	vargrant box prune

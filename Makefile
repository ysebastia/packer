all: alma debian ubuntu

alma: alma9

alma9: alma9_build alma9_install

debian: debian13

debian13: debian13_build debian13_install

ubuntu: ubuntu24

ubuntu24: ubuntu24_build ubuntu24_install

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

ubuntu24_build:
	rm -rf artifacts/ubuntu24
	CHECKPOINT_DISABLE=1 /usr/bin/packer build -var-file="machines/ubuntu24.pkrvars.hcl" vagrant.pkr.hcl
	
ubuntu24_install:
	cd artifacts/ubuntu24 && vagrant box add metadata.json --force

ubuntu24_up:
	cd vagrant/ubuntu24 && vagrant up

ubuntu24_ssh:
	cd vagrant/ubuntu24 && vagrant ssh

ubuntu24_destroy:
	cd vagrant/ubuntu24 && vagrant destroy

vagrant_prune:
	vagrant box prune

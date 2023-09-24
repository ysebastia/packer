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

ubuntu: ubuntu_cloud_build ubuntu_cloud_install

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

ubuntu_cloud_build:
	rm -rf artifacts/ubuntu-server-cloudimg-amd64
	CHECKPOINT_DISABLE=1 packer build -var-file="machines/ubuntu-server-cloudimg-amd64.pkrvars.hcl" terraform.pkr.hcl

ubuntu_cloud_install:
	chmod 755 artifacts/ubuntu-server-cloudimg-amd64/*.img
	sudo cp artifacts/ubuntu-server-cloudimg-amd64/*.img /var/lib/libvirt/images/

ubuntu2204_build:
	rm -rf artifacts/ubuntu2204
	CHECKPOINT_DISABLE=1 packer build -var-file="machines/ubuntu2204.pkrvars.hcl" vagrant.pkr.hcl

ubuntu2204_install:
	cd artifacts/ubuntu2204 && vagrant box add metadata.json --force

ubuntu2204_up:
	cd vagrant/ubuntu2204 && vagrant up

ubuntu2204_ssh:
	cd vagrant/ubuntu2204 && vagrant ssh

ubuntu2204_destroy:
	cd vagrant/ubuntu2204 && vagrant destroy

vagrant_prune:
	vargrant box prune

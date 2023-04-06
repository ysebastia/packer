all: alma debian

alma: alma8 alma9

alma8: alma8_build alma8_install

alma9: alma9_build alma9_install

debian: debian11

debian11: debian11_build debian11_install

debian11_up:
	cd vagrant/debian11 && vagrant up

debian11_ssh:
	cd vagrant/debian11 && vagrant ssh

debian11_destroy:
	cd vagrant/debian11 && vagrant destroy

ubuntu: ubuntu_cloud_build ubuntu_cloud_install

alma8_build:
	rm -rf artifacts/alma8
	CHECKPOINT_DISABLE=1 packer build -var-file="alma8.pkrvars.hcl" vagrant.pkr.hcl

alma8_install:
	cd artifacts/alma8 && vagrant box add metadata.json --force

alma8_up:
	cd vagrant/alma8 && vagrant up

alma8_ssh:
	cd vagrant/alma8 && vagrant ssh

alma8_destroy:
	cd vagrant/alma8 && vagrant destroy

alma9_build:
	rm -rf artifacts/alma9
	CHECKPOINT_DISABLE=1 packer build -var-file="alma9.pkrvars.hcl" vagrant.pkr.hcl

alma9_install:
	cd artifacts/alma9 && vagrant box add metadata.json --force

alma9_up:
	cd vagrant/alma9 && vagrant up

alma9_ssh:
	cd vagrant/alma9 && vagrant ssh

alma9_destroy:
	cd vagrant/alma9 && vagrant destroy

debian11_build:
	rm -rf artifacts/debian11
	CHECKPOINT_DISABLE=1 packer build -var-file="debian11.pkrvars.hcl" vagrant.pkr.hcl
	
debian11_install:
	cd artifacts/debian11 && vagrant box add metadata.json --force

ubuntu_cloud_build:
	rm -rf artifacts/ubuntu-server-cloudimg-amd64
	CHECKPOINT_DISABLE=1 packer build -var-file="ubuntu-server-cloudimg-amd64.pkrvars.hcl" terraform.pkr.hcl

ubuntu_cloud_install:
	chmod 755 artifacts/ubuntu-server-cloudimg-amd64/*.img
	sudo cp artifacts/ubuntu-server-cloudimg-amd64/*.img /var/lib/libvirt/images/

vagrant_prune:
	vargrant box prune

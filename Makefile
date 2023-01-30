all:
	rm -rf artifacts
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 packer build centos.pkr.hcl
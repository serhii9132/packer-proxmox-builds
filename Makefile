ENV_FILE := .env
LOAD_ENV := set -a; [ -f $(ENV_FILE) ] && . ./$(ENV_FILE); set +a

ubuntu2404:
	@packer init builds/ubuntu-24.04/main.pkr.hcl
	@$(LOAD_ENV) && packer build -var-file=commons.pkrvars.hcl builds/ubuntu-24.04/

almalinux8:
	@packer init builds/almalinux-8/main.pkr.hcl
	@$(LOAD_ENV) && packer build -var-file=commons.pkrvars.hcl builds/almalinux-8/

debian13:
	@packer init builds/debian-13/main.pkr.hcl
	@$(LOAD_ENV) && packer build -var-file=commons.pkrvars.hcl builds/debian-13/
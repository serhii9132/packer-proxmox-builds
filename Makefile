ENV_FILE   		:= .env
LOG_DIR    		:= logs
LOG_TIMESTAMP 	:= $(shell date +"%Y-%m-%d_%H-%M-%S")
LOAD_ENV 		:= set -a; [ -f $(ENV_FILE) ] && . ./$(ENV_FILE); set +a

.PHONY: ubuntu almalinux debian clean

init_logs:
	@mkdir -p $(LOG_DIR)

ubuntu: init_logs
	@packer init builds/ubuntu-24.04/main.pkr.hcl
	@$(LOAD_ENV) && \
	export PACKER_LOG_PATH="$(LOG_DIR)/ubuntu_build_$(LOG_TIMESTAMP).log" PACKER_LOG=1 && \
	packer build -var-file=commons.pkrvars.hcl builds/ubuntu-24.04/

almalinux: init_logs
	@packer init builds/almalinux-8/main.pkr.hcl
	@$(LOAD_ENV) && \
	export PACKER_LOG_PATH="$(LOG_DIR)/almalinux_build_$(LOG_TIMESTAMP).log" PACKER_LOG=1 && \
	packer build -var-file=commons.pkrvars.hcl builds/almalinux-8/

debian: init_logs
	@packer init builds/debian-13/main.pkr.hcl
	@$(LOAD_ENV) && \
	export PACKER_LOG_PATH="$(LOG_DIR)/debian_build_$(LOG_TIMESTAMP).log" PACKER_LOG=1 && \
	packer build -var-file=commons.pkrvars.hcl builds/debian-13/

clean:
	rm -rf $(LOG_DIR)
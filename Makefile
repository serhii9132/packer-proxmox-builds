ENV_FILE      := .env
LOG_DIR       := logs
LOG_TIMESTAMP := $(shell date +"%Y-%m-%d_%H-%M-%S")
LOCAL_VARS 	  := $(wildcard local.pkrvars.hcl)
PACKER_CMD 	  := packer build -var-file=vars/common/common.pkrvars.hcl

TARGETS := almalinux-8 debian-13 ubuntu-24

ifneq ($(LOCAL_VARS),)
	PACKER_CMD += -var-file=$(LOCAL_VARS)
endif

.PHONY: init_logs $(TARGETS)

init_logs:
	@mkdir -p $(LOG_DIR)

$(TARGETS): init_logs
	@packer init .
	@export PACKER_LOG_PATH="$(LOG_DIR)/$@_build_$(LOG_TIMESTAMP).log" PACKER_LOG=1 && \
	$(PACKER_CMD) -only=proxmox-iso.$@ -var-file=vars/os/$@.pkrvars.hcl .
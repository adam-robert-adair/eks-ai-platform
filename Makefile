SHELL := /bin/bash
TERRAFORM_DIR := terraform

.PHONY: help tf-fmt tf-validate tflint checkov tf-plan tf-apply tf-destroy kustomize-build teardown

help:
	@echo "Targets: tf-fmt tf-validate tflint checkov tf-plan tf-apply tf-destroy kustomize-build teardown"

tf-fmt:
	terraform -chdir=$(TERRAFORM_DIR) fmt -recursive

tf-validate:
	terraform -chdir=$(TERRAFORM_DIR) init -backend=false
	terraform -chdir=$(TERRAFORM_DIR) validate

tflint:
	cd $(TERRAFORM_DIR) && tflint --init && tflint --recursive

checkov:
	checkov -d $(TERRAFORM_DIR) --framework terraform

tf-plan:
	terraform -chdir=$(TERRAFORM_DIR) init
	terraform -chdir=$(TERRAFORM_DIR) plan

tf-apply:
	terraform -chdir=$(TERRAFORM_DIR) init
	terraform -chdir=$(TERRAFORM_DIR) apply

tf-destroy:
	terraform -chdir=$(TERRAFORM_DIR) init
	terraform -chdir=$(TERRAFORM_DIR) destroy

kustomize-build:
	kustomize build k8s/base

teardown: tf-destroy

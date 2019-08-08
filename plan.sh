#!/bin/bash
rm -rf .terraform
terraform init -backend-config tf-state-initialization/state_config.tfvars
terraform plan -var-file tf-state-initialization/state_config.tfvars
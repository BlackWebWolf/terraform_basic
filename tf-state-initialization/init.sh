#!/bin/bash
terraform init -backend-config state_config.tfvars
terraform apply -var-file state_config.tfvars

infra:
	git pull
	terraform init 
	terraform apply -auto-approve 
ansible:
	git pull
	ansible-playbook -i $(tool_name)-internal.santoshpawar.site, setup-tool.yml -e ansible_user=ec2-user -e ansible_password=DevOps321 -e tool_name=$(tool_name)

#dev-apply:
# 	git pull
# 	rm -f .terraform/terraform.tfstate
# 	terraform init -backend-config=env-dev/state.tfvars
# 	terraform apply -auto-approve -var-file=env-dev/main.tfvars -var vault_token=$(vault_token)

# dev-destroy:
# 	git pull
# 	rm -f .terraform/terraform.tfstate
# 	terraform init -backend-config=env-dev/state.tfvars
# 	terraform destroy -auto-approve -var-file=env-dev/main.tfvars -var vault_token=$(vault_token)

# prod-apply:
# 	git pull
# 	rm -f .terraform/terraform.tfstate
# 	terraform init -backend-config=env-prod/state.tfvars
# 	terraform apply -auto-approve -var-file=env-prod/main.tfvars -var vault_token=$(vault_token)

# prod-destroy:
# 	git pull
# 	rm -f .terraform/terraform.tfstate
# 	terraform init -backend-config=env-prod/state.tfvars
# 	terraform destroy -auto-approve -var-file=env-prod/main.tfvars -var vault_token=$(vault_token)

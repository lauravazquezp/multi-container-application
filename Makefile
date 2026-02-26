VM_IP=$(shell cd terraform && terraform output -raw vm_ip 2>/dev/null)

# local development
install:
	npm install

run:
	@echo "Starting the Todo API locally with nodemon..."
	npm run dev

db-start:
	brew services start mongodb-community

db-stop:
	brew services stop mongodb-community

# local Docker development
docker-up:
	docker compose up -d

docker-down:
	docker compose down

docker-clean:
	docker compose down -v

# infrastructure (local cloud via Terraform)
infra-up:
	cd terraform && terraform init && terraform apply -auto-approve

infra-down:
	cd terraform && terraform destroy -auto-approve

# remote configuration & deployment (Ansible)
deploy:
	cd ansible && ansible-playbook -i inventory.ini playbook.yml -u ubuntu

ssh:
	ssh ubuntu@$(VM_IP)

logs:
	ssh ubuntu@$(VM_IP) "cd app && docker-compose logs -f app"

# cleanup
clean:
	rm -rf node_modules
	cd terraform && rm -rf .terraform .terraform.lock.hcl .terraform.tfstate*

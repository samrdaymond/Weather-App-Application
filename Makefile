COMPOSE_RUN_TERRAFORM = docker-compose run --rm tf
COMPOSE_RUN_BASH = docker-compose run --rm --entrypoint bash tf
COMPOSE_RUN_AWS = docker-compose run --rm --entrypoint aws tf

DOCKER_BUILD = docker build -f ./dockerfile -t $(IMAGE_NAME):1 .
DOCKER_TAG = docker tag $(IMAGE_NAME):1 $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/$(REPO_NAME):1
DOCKER_PUSH = docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/$(REPO_NAME):1
ECR_LOGIN = ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

#Terraform Commands
.PHONY: run_plan
run_plan: init plan

.PHONY: run_apply
run_apply: init apply

.PHONY: run_destroy_plan
run_destroy_plan: init destroy_plan

.PHONY: run_destroy_apply
run_destroy_apply: init destroy_apply

.PHONY: version
version:
	$(COMPOSE_RUN_TERRAFORM) --version
	
.PHONY: init
init:
	$(COMPOSE_RUN_TERRAFORM) init -input=false
	-$(COMPOSE_RUN_TERRAFORM) validate
	-$(COMPOSE_RUN_TERRAFORM) fmt

.PHONY: plan
plan:
	$(COMPOSE_RUN_TERRAFORM) plan -out=tfplan -input=false

.PHONY: apply
apply:
	$(COMPOSE_RUN_TERRAFORM) apply "tfplan"

.PHONY: destroy_plan
destroy_plan:
	$(COMPOSE_RUN_TERRAFORM) plan -destroy

.PHONY: destroy_apply
destroy_apply:
	$(COMPOSE_RUN_TERRAFORM) destroy -auto-approve

.PHONY: list_bucket
list_bucket: 
	$(COMPOSE_RUN_AWS) s3 ls

#Docker Commands

.PHONY: docker_push_image
docker_push: init docker_build docker_tag aws_login docker_push

.PHONY: docker_build
docker_build: $(DOCKER_BUILD)

.PHONY: docker_tag
docker_tag: $(DOCKER_TAG)

.PHONY: aws_login
aws_login: $(COMPOSE_RUN_AWS) $(ECR_LOGIN)

.PHONY: docker_push
docker_push: $(DockerPush)


.PHONY: help ps build build-prod start fresh fresh-prod stop restart destroy \
	cache cache-clear migrate migrate migrate-fresh tests tests-html

CONTAINER_PHP=api
CONTAINER_REDIS=redis
CONTAINER_DATABASE=database

help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

auth: ##Authenticate with AWS
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 800067687844.dkr.ecr.us-east-1.amazonaws.com
	
build-push: ## Build and push to image production
	make build
	make push

build: ## Build the image containers
	docker build -t projeto-puc-calcproj-image .

push: ## Push to image production
	docker tag projeto-puc-calcproj-image:latest 800067687844.dkr.ecr.us-east-1.amazonaws.com/projeto-puc-calcproj-image:latest
	docker push 800067687844.dkr.ecr.us-east-1.amazonaws.com/projeto-puc-calcproj-image:latest
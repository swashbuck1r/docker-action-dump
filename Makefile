DIST_DIR := $(CURDIR)/dist
VERSION ?= v1
APP_NAME=docker-action-dump
IMAGE := $(APP_NAME):$(VERSION)

# Set the default shell to use for shell commands
SHELL := /bin/bash

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

##@ Build

.PHONY: build
build: ## Build the action source
	docker build -t $(APP_NAME) .

.PHONY: release
release: ## Build and publish the release
	git commit -a -m "publish release: $(VERSION)"
	git push origin HEAD:$(VERSION)

run: ## Run container on port configured in `config.env`
	docker run -i -t --rm --name="$(APP_NAME)" -e CHOKIDAR_USEPOLLING=true $(APP_NAME)

shell:
	docker run -i -t --rm --name="$(APP_NAME)" --entrypoint bash $(APP_NAME)

stop: ## Stop and remove a running container
	docker stop $(APP_NAME); docker rm $(APP_NAME)

stop-hard: ## Stop and remove a running container forcefully
	docker rm -f $(APP_NAME)
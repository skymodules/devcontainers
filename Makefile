DEVCONTAINER := "alibaba"
IMAGE_NAME := "skymodules/$(DEVCONTAINER)"
ID_LABEL="ci-container=$(DEVCONTAINER)"
ENV_FILES := ./.env

include $(ENV_FILES)

.PHONY:default
# display environment configuration values
default: 
	@echo "DEVCONTAINER: $(DEVCONTAINER)"
	@dotenvx run --quiet -f $(ENV_FILES) -- doppler run -- echo "Ready"
	@dotenvx run --quiet -f $(ENV_FILES) -- doppler run -- gh auth status
	@dotenvx run --quiet -f $(ENV_FILES) -- doppler run -- echo "$$GH_TOKEN"
	@dotenvx run --quiet -f $(ENV_FILES) -- doppler run -- echo "$$GH_USERNAME"

.PHONY: setup/gpg
# setup gpg on the build machine
setup/gpg:
	@dotenvx run --quiet -f $(ENV_FILES) -- doppler run -- echo "Setting up gpg"
	@dotenvx run --quiet -f $(ENV_FILES) -- doppler run -- ./.scripts/gpg.sh


#
# base image
#

.PHONY: base/build
# build base image
base/build:
	@docker build -t skymodules/base:latest -f ./base/Dockerfile ./base


.PHONY: base/publish
# publish base image to github
base/publish:
	@doppler run -- echo $GH_TOKEN | docker login ghcr.io -u USERNAME --password-stdin


#
# devcontainer
#
.PHONY:list 
# list all sub-directories except .github, .vscode, and .git and remove trailing slash
list:
	@ls -d */ | grep -v -e ".github" -e ".vscode" -e ".git" | sed 's/\/$$//'


.PHONY: build
# build the devcontainer
# @doppler run -- devcontainer build --workspace-folder "./$(DEVCONTAINER)" --config "./$(DEVCONTAINER)/devcontainer.json" --log-level info --image-name $(IMAGE_NAME)
# @dotenvx run --quiet -f $(ENV_FILES) -- doppler run -- devcontainer build --workspace-folder "./$(DEVCONTAINER)" --config "./$(DEVCONTAINER)/devcontainer.json" --log-level info --image-name "skymodules/$(DEVCONTAINER)"
build:
	@dotenvx run --quiet -f $(ENV_FILES) -- doppler run -- echo $$GH_TOKEN | docker login ghcr.io -u rexwhitten --password-stdin
	@dotenvx run --quiet -f $(ENV_FILES) -- doppler run -- devcontainer build --workspace-folder "./$(DEVCONTAINER)" --config "./$(DEVCONTAINER)/devcontainer.json" --log-level info --image-name "skymodules/$(DEVCONTAINER)"

.PHONY: up
# up 
up:
	@echo "Starting devcontainer: $(DEVCONTAINER) with image: $(IMAGE_NAME) and id label: $(ID_LABEL)"; \
	devcontainer up --workspace-folder "./$(DEVCONTAINER)" --config "./$(DEVCONTAINER)/devcontainer.json" --id-label "$(ID_LABEL)" || true; \
	docker rm -f $$(docker ps -aq --filter label=$(ID_LABEL)) || true

.PHONY: publish
# publish the devcontainer to github
publish:
	@doppler -- echo $$GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin`	


#
# all
# 

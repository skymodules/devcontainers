DEVCONTAINER := "alibaba"
IMAGE_NAME := "skymodules/$(DEVCONTAINER)"
ID_LABEL="ci-container=$(DEVCONTAINER)"
ENV_FILES := ./.env

.PHONY:default
# display environment configuration values
default:
	@echo "DEVCONTAINER: $(DEVCONTAINER)"
	@dotenvx run --quiet -f --$(ENV_FILES) -- doppler run -- echo "Ready"

.PHONY:list 
# list all sub-directories except .github, .vscode, and .git and remove trailing slash
list:
	@ls -d */ | grep -v -e ".github" -e ".vscode" -e ".git" | sed 's/\/$$//'

.PHONY: build
# build the devcontainer
build:
	@devcontainer build --workspace-folder "./$(DEVCONTAINER)" --config "./$(DEVCONTAINER)/devcontainer.json" --log-level info --image-name $(IMAGE_NAME)

.PHONY: up
# up 
up:
	@echo "Starting devcontainer: $(DEVCONTAINER) with image: $(IMAGE_NAME) and id label: $(ID_LABEL)"; \
	devcontainer up --workspace-folder "./$(DEVCONTAINER)" --config "./$(DEVCONTAINER)/devcontainer.json" --id-label "$(ID_LABEL)" || true; \
	docker rm -f $$(docker ps -aq --filter label=$(ID_LABEL)) || true


.PHONY: build/all
# build all devcontainers
build/all:
	@ls -d */ | grep -v -e ".github" -e ".vscode" -e ".git" | sed 's/\/$$//' | xargs -I {} devcontainer build --workspace-folder "./{}" --config "./{}/devcontainer.json" --log-level info --image-name "skymodules/{}"

.PHONY: publish
# publish the devcontainer to github
publish:
	@doppler -- echo $$GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
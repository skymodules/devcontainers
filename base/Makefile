#
# base image
#
.PHONY: base/build
# build base image
base/build:
	@docker build -t $$ORG_NAME/base:latest -f ./base/Dockerfile ./base


.PHONY: base/publish
# publish base image to github
base/publish:
	@doppler run -- echo $GH_TOKEN | docker login ghcr.io -u USERNAME --password-stdin

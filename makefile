IMAGENAME  = build-tools
VERSION   ?= 0.0.4-dev
TAG = zenoss/$(IMAGENAME):$(VERSION)

.PHONY: build push clean

build:
	@echo Building build-tools image
	@docker build -t $(TAG) .

push:
	docker push $(TAG)

clean:
	-docker rmi $(TAG)

# Generate a make failure if the VERSION string contains "-<some letters>"
verifyVersion:
	@./verifyVersion.sh $(VERSION)

# Generate a make failure if the image(s) already exist
verifyImage:
	@./verifyImage.sh zenoss/$(IMAGENAME) $(VERSION)

# Do not release if the image version is invalid
# This target is intended for use when trying to build/publish images from the master branch
release: verifyVersion verifyImage clean build push

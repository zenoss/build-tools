IMAGENAME  = build-tools
VERSION   ?= 0.0.4-dev
TAG = zenoss/$(IMAGENAME):$(VERSION)
JENKINS-TAG = $(TAG)-jenkins

.PHONY: build push clean

build: Dockerfile-jenkins
	@echo Building build-tools image
	@docker build -t $(TAG) .
	@docker build -t $(JENKINS-TAG) -f Dockerfile-jenkins .

Dockerfile-jenkins:
	@echo $(TAG)
	@echo supriya
	@sed -e 's/%BUILDTOOLSTAG%/zenoss\/$(IMAGENAME):$(VERSION)/g' Dockerfile-jenkins.in > $@

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

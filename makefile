IMAGENAME  = build-tools
VERSION   ?= 0.0.1-dev-1
TAG = zenoss/$(IMAGENAME):$(VERSION)

.PHONY: build push clean

build:
	@echo Building build-tools image
	@docker build -t $(TAG) .

push:
	docker push $(TAG)

clean:
	docker rmi $(TAG)
image:
	docker build -t $(TAG) .


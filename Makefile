DRUPAL_CMS_VER ?= 2.1.0
DRUPAL_CMS_VER_MAJOR ?= $(shell echo "${DRUPAL_CMS_VER}" | grep -oE '^[0-9]+')

PHP_VER ?= 8.4
BASE_IMAGE_TAG = $(PHP_VER)

REPO = wodby/drupal-cms
NAME = drupal-cms-$(DRUPAL_CMS_VER_MAJOR)

TAG ?= $(DRUPAL_CMS_VER_MAJOR)

PLATFORM ?= linux/amd64

ifneq ($(BASE_IMAGE_STABILITY_TAG),)
    BASE_IMAGE_TAG := $(BASE_IMAGE_TAG)-$(BASE_IMAGE_STABILITY_TAG)
endif

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

.PHONY: build buildx-build buildx-build-amd64 buildx-push push shell run start stop logs clean release

# Resolve the same pinned base image for every local and CI build target.
include base-images.mk

default: build

build:
	docker build --build-arg BASE_IMAGE="$(BASE_IMAGE)" -t $(REPO):$(TAG) \
		--build-arg DRUPAL_CMS_VER=$(DRUPAL_CMS_VER) \
		./

# --load doesn't work with multiple platforms https://github.com/docker/buildx/issues/59
# we need to save cache to run tests first.
buildx-build-amd64:
	docker buildx build --build-arg BASE_IMAGE="$(BASE_IMAGE)" --platform linux/amd64 -t $(REPO):$(TAG) \
		--build-arg DRUPAL_CMS_VER=$(DRUPAL_CMS_VER) \
		--load \
		./

buildx-build:
	docker buildx build --build-arg BASE_IMAGE="$(BASE_IMAGE)" --platform $(PLATFORM) -t $(REPO):$(TAG) \
		--build-arg DRUPAL_CMS_VER=$(DRUPAL_CMS_VER) \
		./

buildx-push:
	docker buildx build --build-arg BASE_IMAGE="$(BASE_IMAGE)" --platform $(PLATFORM) --push -t $(REPO):$(TAG) \
		--build-arg DRUPAL_CMS_VER=$(DRUPAL_CMS_VER) \
		./

test:
	cd ./tests && IMAGE=$(REPO):$(TAG) ./run.sh

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push

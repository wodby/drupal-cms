# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := wodby/drupal-php
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_8.4 := sha256:e56d69cb19212ba366d17522fce94c70151a6320fb7fdf427e65ca82046c69f4
BASE_IMAGE_DIGEST_8.4-r16 := sha256:709749037af6af549b42ef45a178faa16f9c0bb09d81f0749777f40dab0b88c8

# Fail before building when a version or variant has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))

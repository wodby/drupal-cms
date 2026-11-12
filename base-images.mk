# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := wodby/drupal-php
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_8.4 := sha256:1ed492e0c772a8e665e147e5df236f240f40abae504e17e19a9265e9f2418153
BASE_IMAGE_DIGEST_8.4-r19 := sha256:4ca3075a9a69c71b5403578d1573e8add3859a489c9d82d0a2b28e9e90267c34

# Fail before building when a version or variant has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))

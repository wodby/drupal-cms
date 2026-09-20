# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := wodby/drupal-php
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_8.4 := sha256:1be9d9b7fe892ae1b877b63f7eae0dec89db2e7afe61e69369f31a0c1443dd14
BASE_IMAGE_DIGEST_8.4-4.83.2 := sha256:f6e0de81ac72ce8aba55be5981f7fd2fd757b3ecd2dfd01ff4750f9fdcbee057
BASE_IMAGE_DIGEST_8.4-4.83.3 := sha256:1f0c0d2600f197bd52592ae479dda3422d1af95ee02107b00d8e5a0549681ce8

# Fail before building when a version or variant has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))

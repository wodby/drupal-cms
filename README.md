# Drupal CMS Docker Container Image

[![Build Status](https://github.com/wodby/drupal-cms/workflows/Build%20docker%20image/badge.svg)](https://github.com/wodby/drupal-cms/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/drupal-cms.svg)](https://hub.docker.com/r/wodby/drupal-cms)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/drupal-cms.svg)](https://hub.docker.com/r/wodby/drupal-cms)

## Docker Images

❗For better reliability we release images with stability tags (`wodby/drupal-cms:1-X.X.X`) which correspond
to [git tags](https://github.com/wodby/drupal-cms/releases). We strongly recommend using images only with stability tags.

Overview:

- All images based on Alpine Linux
- Base image: [wodby/drupal-php](https://github.com/wodby/drupal-php)
- [GitHub actions builds](https://github.com/wodby/drupal-cms/actions)
- [Docker Hub](https://hub.docker.com/r/wodby/drupal-cms)

| Supported tags and respective `Dockerfile` links                                                | Drupal CMS | PHP |
|-------------------------------------------------------------------------------------------------|------------|-----|
| `1`, `1.1`, `latest` [_(Dockerfile)_](https://github.com/wodby/drupal-cms/tree/main/Dockerfile) | 1.0        | 8.3 |

All images built for `linux/amd64` and `linux/arm64`

## Environment Variables

##### settings.php variables

| Variable                       | Default Value                             |
|--------------------------------|-------------------------------------------|
| `DB_HOST`                      | `mariadb`                                 |
| `DB_NAME`                      | `drupal`                                  |
| `DB_USER`                      | `drupal`                                  |
| `DB_PASSWORD`                  | `drupal`                                  |
| `DB_DRIVER`                    | `mysql`                                   |
| `DB_PREFIX`                    |                                           |
| `DRUPAL_TRUSTED_HOST_PATTERNS` | `'\\.localhost$', '\\.local$', '\\.loc$'` |

See [wodby/drupal-php](https://github.com/wodby/drupal-php) for all variables.

## Orchestration Actions

See [wodby/drupal-php](https://github.com/wodby/drupal-php) for all actions.

## Complete Drupal Stack

See [wodby/docker4drupal](https://github.com/wodby/docker4drupal)

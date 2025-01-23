ARG BASE_IMAGE_TAG

FROM wodby/drupal-php:${BASE_IMAGE_TAG}

ARG DRUPAL_CMS_VER

ENV DRUPAL_CMS_VER="${DRUPAL_CMS_VER}" \
    DOCROOT_SUBDIR="web" \
    APP_NAME="Drupal CMS"

USER root

RUN set -ex; \
    \
    mv /usr/local/bin/actions.mk /usr/local/bin/drupal-php.mk; \
    mkdir -p /usr/src/drupal; \
    chown wodby:wodby -R /usr/src; \
    \
    COMPOSER_MEMORY_LIMIT=-1 su-exec wodby composer create-project "drupal/cms:${DRUPAL_CMS_VER}" /usr/src/drupal --no-interaction; \
    \
    cd /usr/src/drupal; \
    cp web/sites/default/default.settings.php web/sites/default/settings.php; \
    mkdir -p web/sites/default/files; \
    chmod 777 web/sites/default/files; \
    chown wodby:wodby web/sites/default/settings.php web/sites/default/files; \
    \
    if [[ -z "${PHP_DEV}" ]]; then \
        echo "$(cat /etc/sudoers.d/wodby), /usr/local/bin/init" > /etc/sudoers.d/wodby; \
    fi; \
    \
    su-exec wodby composer clear-cache

USER wodby

COPY templates/settings.php.tmpl /etc/gotpl/
COPY init /docker-entrypoint-init.d/
COPY bin /usr/local/bin/
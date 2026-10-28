#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

cid="$(
	docker run -d -e WODBY_APP_NAME=Test "${IMAGE}"
)"
trap "docker rm -vf ${cid} > /dev/null" EXIT

docker exec "${cid}" make init -f /usr/local/bin/actions.mk
echo -n "Checking drush status... "
docker exec "${cid}" drush -r "/var/www/html/web" status | grep -q 'Drupal root'
echo "OK"
echo -n "Checking site templates... "
docker exec "${cid}" test -f /var/www/html/recipes/drupal_cms_blank/recipe.yml
docker exec "${cid}" test -f /var/www/html/recipes/drupal_cms_starter/recipe.yml
echo "OK"

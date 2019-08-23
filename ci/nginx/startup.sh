#!/bin/sh

cp -R /opt/index-src/* /opt/www/public

# Replace the resource paths in index yaml files to match the specified external URL
find /opt/www/public -name '*.yaml' -exec sed -i -r "s|https://(.*)/(.*)$|$EXTERNAL_URL/\2|" {} \;

if [ -z "${DRY_RUN}" ]
then
    exec nginx
fi

FROM registry.access.redhat.com/ubi7/ubi-minimal

LABEL name="appsody-index" \
      vendor="Appsody" \
      version="0.1.0" \
      release="1" \
      summary="Nginx host for stacks" \
      description="Nginx container to host stacsk"

COPY nginx/nginx.repo  /etc/yum.repos.d/nginx.repo

RUN microdnf install nginx

COPY nginx/nginx.conf  /etc/nginx/nginx.conf
COPY nginx/startup.sh  /opt/startup.sh
COPY assets            /opt/www/public
COPY build/prefetch    /opt/www/public
COPY build/index-src   /opt/index-src

RUN rm /opt/www/public/*-local.yaml

EXPOSE 8080

RUN touch /var/run/nginx.pid && \
  chown -R nginx:0 /var/run/nginx.pid /var/cache/nginx /opt/www/public /etc/nginx /run /var/log/nginx/ && \
  chmod -R g=u /opt/www/public /var/cache/nginx /etc/nginx /var/run/nginx.pid /run /var/log/nginx/

USER nginx

ENTRYPOINT ["/opt/startup.sh"]

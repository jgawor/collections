FROM nginx:stable-alpine

COPY nginx/nginx.conf  /etc/nginx/nginx.conf
COPY nginx/startup.sh  /opt/startup.sh
COPY assets            /opt/www/public

EXPOSE 8080

RUN touch /var/run/nginx.pid && \
  chown -R www-data:www-data /var/run/nginx.pid && \
  chown -R www-data:www-data /var/cache/nginx && \
  chown -R www-data:www-data /opt/www/public

USER www-data

ENTRYPOINT ["/opt/startup.sh"]

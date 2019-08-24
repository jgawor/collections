FROM nginx:stable-alpine

COPY nginx/nginx.conf  /etc/nginx/nginx.conf
COPY nginx/startup.sh  /opt/startup.sh
COPY assets            /opt/www/public

EXPOSE 8080

RUN touch /var/run/nginx.pid && \
  chown -R nginx:nginx /var/run/nginx.pid && \
  chown -R nginx:nginx /var/cache/nginx && \
  chown -R nginx:nginx /opt/www/public &&
  chmod -R g=u /opt/www/public /var/cache/nginx

USER nginx

ENTRYPOINT ["/opt/startup.sh"]

FROM nginx:stable-alpine

COPY nginx/nginx.conf  /etc/nginx/nginx.conf
COPY nginx/startup.sh  /opt/startup.sh
COPY assets            /opt/www/public

EXPOSE 8080

ENTRYPOINT ["/opt/startup.sh"]

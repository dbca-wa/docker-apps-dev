# Prepare the base environment.
FROM bytemark/webdav:latest as builder_base

RUN mv /etc/passwd /etc/passwd-old
RUN cat /etc/passwd-old  | grep -v www-data > /etc/passwd
RUN echo "www-data:x:1000:1000:Linux User,,,:/home/www-data:/bin/false" >> /etc/passwd
COPY httpd.default.conf /usr/local/apache2/conf/sites-available
EXPOSE 80/tcp 443/tcp
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "httpd-foreground" ]

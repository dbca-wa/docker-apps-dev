# Prepare the base environment.
FROM dbcawa/boranga:latest as builder_base_borangadev

RUN apt-get update
RUN apt-get install --no-install-recommends -y npm patch
RUN apt-get install --no-install-recommends -y libpq-dev git ssh sudo 
RUN apt-get install --no-install-recommends -y screen
RUN apt-get install --no-install-recommends -y virtualenv
RUN openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj  "/C=AU/ST=Western Australia/L=Perth/O=Development Environment/OU=IT Department/CN=example.com"  -keyout /etc/ssl/private/selfsignedssl.key -out /etc/ssl/private/selfsignedssl.crt

RUN groupadd -g 1000 docker
RUN useradd -g 1000 -u 1000 docker -s /bin/bash
RUN mkdir /home/docker
RUN chown docker.docker /home/docker
RUN cp /root/.bashrc /home/docker
RUN cp /root/.profile /home/docker
RUN echo "cd /data/" >> /home/docker/.bashrc

EXPOSE 8080
HEALTHCHECK --interval=1m --timeout=5s --start-period=10s --retries=3 CMD ["wget", "-q", "-O", "-", "http://localhost:8080/"]
CMD ["/startup.sh"]

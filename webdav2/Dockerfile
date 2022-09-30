# Prepare the base environment.
FROM ubuntu:22.04 as builder_base_docker
MAINTAINER asi@dbca.wa.gov.au
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV PRODUCTION_EMAIL=True
ENV SECRET_KEY="ThisisNotRealKey"
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y  wget git libmagic-dev gcc binutils libproj-dev gdal-bin python3 python3-setuptools python3-dev python3-pip tzdata cron rsyslog apache2 
RUN apt-get install --no-install-recommends -y libpq-dev
RUN apt-get install --no-install-recommends -y postfix libsasl2-modules
RUN apt-get install -y vim
# Example Self Signed Cert
RUN apt-get install -y openssl
RUN openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj  "/C=AU/ST=Western Australia/L=Perth/O=DBCA/OU=IT Department/CN=example.com"  -keyout /etc/ssl/private/selfsignedssl.key -out /etc/ssl/private/selfsignedssl.crt

RUN ln -s /usr/bin/python3 /usr/bin/python 
#RUN ln -s /usr/bin/pip3 /usr/bin/pip
RUN pip install --upgrade pip

# Install Python libs from requirements.txt.

WORKDIR /app

# Install the project (ensure that frontend projects have been built prior to this step).
FROM python_libs_docker
# Set  local perth time
COPY timezone /etc/timezone
ENV TZ=Australia/Perth
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY sites.conf /etc/apache2/sites-enabled/
RUN mkdir /etc/webconfs/
RUN mkdir /etc/webconfs/apache/ 
RUN mkdir /var/web/
RUN mkdir /etc/postfix-conf/
RUN a2enmod ssl
RUN mkdir /var/www/webdav
RUN chown www-data:www-data /var/www/webdav
RUN mkdir -p /usr/local/apache/var/
RUN chown www-data:www-data /usr/local/apache/var
COPY webdav.conf /etc/apache2/sites-enabled/
RUN systemctl restart apache2.service
RUN touch /usr/local/apache/var/users.password
RUN sudo chown www-data:www-data /usr/local/apache/var/users.password
#RUN htdigest /usr/local/apache/var/users.password docker docker


RUN touch /app/.env
COPY boot.sh /
RUN touch /etc/cron.d/dockercron
RUN cron /etc/cron.d/dockercron
RUN chmod 755 /boot.sh
EXPOSE 80
HEALTHCHECK --interval=5s --timeout=2s CMD ["wget", "-q", "-O", "-", "http://localhost:80/"]
CMD ["/boot.sh"]

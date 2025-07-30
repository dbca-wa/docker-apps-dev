# Prepare the base environment.
FROM ubuntu:24.04 as builder_base_docker
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV PRODUCTION_EMAIL=True
ENV SECRET_KEY="ThisisNotRealKey"
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y wget git libmagic-dev gcc binutils libproj-dev gdal-bin python3 python3-setuptools python3-dev python3-pip tzdata libreoffice cron rsyslog curl
RUN apt-get install --no-install-recommends -y libpq-dev patch virtualenv wine unzip
RUN apt-get install --no-install-recommends -y mtr
RUN apt-get install --no-install-recommends -y vim ssh htop
RUN apt-get install --no-install-recommends -y python3-pil
RUN apt-get install --no-install-recommends -y patch
RUN apt-get install --no-install-recommends -y libpq-dev git ssh sudo
RUN apt-get install --no-install-recommends -y screen
RUN openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj  "/C=AU/ST=Western Australia/L=Perth/O=Development Environment/OU=IT Department/CN=example.com"  -keyout /etc/ssl/private/selfsignedssl.key -out /etc/ssl/private/selfsignedssl.crt

# For Linux
RUN groupadd -g 20000 container
RUN useradd -g 20000 -u 200000 container -s /bin/bash
RUN mkdir /home/container
RUN chown container.container /home/container
RUN cp /root/.bashrc /home/container
RUN cp /root/.profile /home/container

RUN echo 'if ! [ -n "${SUDO_USER}" -a -n "${SUDO_PS1}" ]; then' >> /etc/bash.bashrc
RUN echo "export PS1='\[\e[0;31mdev:\e[0;32m \u@\h:~ \e[0;34m\W\$\e\[\e[0m\] '" >> /etc/bash.bashrc
RUN echo "fi" >> /etc/bash.bashrc

RUN mkdir /usr/lib/pythonwindows/
RUN wget https://www.python.org/ftp/python/3.12.9/python-3.12.9-amd64.zip -O /usr/lib/pythonwindows/python-windows.zip
RUN cd /usr/lib/pythonwindows/ ; unzip python-windows.zip
#RUN wine /usr/lib/pythonwindows/python.exe -m pip install --upgrade pip
RUN wine /usr/lib/pythonwindows/python.exe -m pip install pyinstaller
RUN wine /usr/lib/pythonwindows/python.exe -m pip install requests

WORKDIR /app
COPY timezone /etc/timezone
ENV TZ=Australia/Perth
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY startup.sh /
RUN chmod 755 /startup.sh
USER container
EXPOSE 8080
CMD ["/startup.sh"]

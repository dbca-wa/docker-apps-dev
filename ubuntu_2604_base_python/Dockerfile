FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu2604_base_latest as builder_base_ubuntu2604
MAINTAINER asi@dbca.wa.gov.au

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth

RUN apt-get clean
RUN apt-get update
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get upgrade -y



RUN apt-get install --no-install-recommends -y curl wget git libmagic-dev gcc binutils libproj-dev gdal-bin python3 python3-setuptools python3-dev python3-pip tzdata rsyslog gunicorn virtualenv 
RUN apt-get install --no-install-recommends -y libpq-dev patch libreoffice
RUN apt-get install --no-install-recommends -y postgresql-client mtr htop vim nano sudo sysstat 
RUN apt-get install --no-install-recommends -y bzip2 unzip
RUN apt-get install --no-install-recommends -y graphviz libgraphviz-dev pkg-config sqlite3 
RUN ln -s /usr/bin/python3 /usr/bin/python 

RUN LATEST_TAG=$(curl -s https://github.com | jq -r '.tag_name') && \
    CHISEL_VERSION=$(echo "$LATEST_TAG" | sed 's/^v//') && \
    echo "Fetching Jpillora Chisel release: ${LATEST_TAG}" && \
    curl -SL "https://github.com{LATEST_TAG}/chisel_${CHISEL_VERSION}_linux_amd64.gz" -o chisel.gz && \
    gunzip chisel.gz && \
    chmod +x chisel

RUN chisel cut --release ubuntu-26.04 --root /rootfs \
    base-files_base \
    base-files_release-info \
    libc6_libs
    
# libpython3.13_libs \
# python3.13_core

# Default Scripts
RUN wget https://raw.githubusercontent.com/dbca-wa/wagov_utils/main/wagov_utils/bin/default_script_installer.sh -O /tmp/default_script_installer.sh
RUN chmod 755 /tmp/default_script_installer.sh
RUN /tmp/default_script_installer.sh

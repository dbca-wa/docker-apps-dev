FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu2510_base_latest as builder_base_ubuntu2510
MAINTAINER asi@dbca.wa.gov.au

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV NODE_MAJOR=20

RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y curl wget git libmagic-dev gcc g++ make binutils libproj-dev gdal-bin python3 python3-setuptools python3-dev python3-pip tzdata rsyslog gunicorn virtualenv
RUN apt-get install --no-install-recommends -y libpq-dev patch libreoffice
RUN apt-get install --no-install-recommends -y postgresql-client mtr htop vim nano npm sudo
RUN apt-get install --no-install-recommends -y bzip2 unzip
RUN apt-get install --no-install-recommends -y graphviz libgraphviz-dev pkg-config sqlite3 htop
RUN ln -s /usr/bin/python3 /usr/bin/python 
RUN apt remove -y libnode-dev
RUN apt remove -y libnode72

# Install nodejs
RUN update-ca-certificates

RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" \
    | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs

# Default Scripts
RUN wget https://raw.githubusercontent.com/dbca-wa/wagov_utils/main/wagov_utils/bin/default_script_installer.sh -O /tmp/default_script_installer.sh
RUN chmod 755 /tmp/default_script_installer.sh
RUN /tmp/default_script_installer.sh

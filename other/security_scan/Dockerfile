FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu2604_base_latest as builder_base_ubuntu2604
MAINTAINER asi@dbca.wa.gov.au
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth

RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y curl wget git gcc binutils libproj-dev tzdata 
RUN apt-get install --no-install-recommends -y bzip2 unzip

RUN groupadd -g 5000 oim 
RUN useradd -g 5000 -u 5000 oim -s /bin/bash -d /app
RUN mkdir /app 
RUN chown -R oim:oim /app 

RUN wget -qO- https://get.anchore.io/syft | sh -s -- -b /usr/local/bin
RUN wget -qO- https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin

# Default Scripts
RUN wget https://raw.githubusercontent.com/dbca-wa/wagov_utils/main/wagov_utils/bin/default_script_installer.sh -O /tmp/default_script_installer.sh
RUN chmod 755 /tmp/default_script_installer.sh
RUN /tmp/default_script_installer.sh

# Default Scripts
RUN wget https://raw.githubusercontent.com/dbca-wa/wagov_utils/refs/heads/main/wagov_utils/bin/azcopy_install.sh -O /tmp/azcopy_install.sh
RUN chmod 755 /tmp/azcopy_install.sh
RUN /tmp/azcopy_install.sh

USER oim

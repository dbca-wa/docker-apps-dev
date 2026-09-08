FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu2604_base_latest as builder_base_ubuntu2604
MAINTAINER asi@dbca.wa.gov.au
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth

RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y curl wget git gcc binutils skopeo libproj-dev tzdata 
RUN apt-get install --no-install-recommends -y bzip2 unzip python3 ca-certificates vim

RUN groupadd -g 5000 oim 
RUN useradd -g 5000 -u 5000 oim -s /bin/bash -d /app

RUN mkdir /app 
COPY assets /app/assets
RUN chown -R oim:oim /app 

RUN wget -qO- https://get.anchore.io/syft | sh -s -- -b /usr/local/bin
RUN wget -qO- https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin

USER oim

FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu_2604_base_python as builder_base_ubuntu2604_python
MAINTAINER asi@dbca.wa.gov.au

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV NODE_MAJOR=24

RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y

# Install nodejs
RUN update-ca-certificates
RUN cd /tmp/ ; wget https://nodejs.org/dist/v26.12.0/node-v26.12.0-linux-x64.tar.xz
RUN cd /tmp/ ; tar -xf node-v26.12.0-linux-x64.tar.xz --directory /usr/local --strip-components 1
RUN node -v
RUN npm -v
RUN npm install -g npm@latest
RUN npm -v
# RUN cd /tmp ; npm pack brace-expansion@5.0.12 ; tar -xzf brace-expansion-5.0.12.tgz ;  rm -rf /usr/local/lib/node_modules/npm/node_modules/brace-expansion ; cp -a package   /usr/local/lib/node_modules/npm/node_modules/brace-expansion
# RUN cd /tmp; npm pack undici@6.28.1 ;tar -xzf undici-6.28.1.tgz ; rm -rf /usr/local/lib/node_modules/npm/node_modules/undici ; cp -a package   /usr/local/lib/node_modules/npm/node_modules/undici
# RUN cd /tmp ;  npm pack ip-address@latest ;  tar -xzf ip-address-*.tgz ;  rm -rf /usr/local/lib/node_modules/npm/node_modules/ip-address ;  cp -a package   /usr/local/lib/node_modules/npm/node_modules/ip-address
# RUN cd /tmp ;  npm pack postcss-selector-parser@latest ;  tar -xzf postcss-selector-parser-*.tgz ;  rm -rf /usr/local/lib/node_modules/npm/node_modules/postcss-selector-parser ;  cp -a package   /usr/local/lib/node_modules/npm/node_modules/postcss-selector-parser
# RUN cd /tmp ;  npm pack http-cache-semantics@latest ;  tar -xzf http-cache-semantics-*.tgz ;  rm -rf /usr/local/lib/node_modules/npm/node_modules/http-cache-semantics ;  cp -a package   /usr/local/lib/node_modules/npm/node_modules/http-cache-semantics

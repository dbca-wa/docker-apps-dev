FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu_2604_base_python as builder_base_ubuntu2604_python
MAINTAINER asi@dbca.wa.gov.au

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV NODE_MAJOR=24

RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
# RUN apt-get install --no-install-recommends -y curl wget git libmagic-dev gcc g++ make binutils libproj-dev gdal-bin python3 python3-setuptools python3-dev python3-pip tzdata rsyslog gunicorn virtualenv
# RUN apt-get install --no-install-recommends -y libpq-dev patch libreoffice
# RUN apt-get install --no-install-recommends -y postgresql-client mtr htop vim nano npm sudo sysstat 
# RUN apt-get install --no-install-recommends -y bzip2 unzip
# RUN apt-get install --no-install-recommends -y graphviz libgraphviz-dev pkg-config sqlite3 
# RUN apt-get install --no-install-recommends -y build-essential
# RUN ln -s /usr/bin/python3 /usr/bin/python 
# RUN apt remove -y libnode-dev
# RUN apt remove -y libnode72

# Install nodejs
RUN update-ca-certificates
# RUN mamba install -y -c conda-forge nodejs=24 &&  mamba clean -afy
RUN cd /tmp/ ; wget https://nodejs.org/dist/v24.21.0/node-v24.21.0-linux-x64.tar.xz
RUN cd /tmp/ ; tar -xf node-v24.21.0-linux-x64.tar.xz --directory /usr/local --strip-components 1
RUN node -v
RUN npm -v
RUN npm install -g npm@latest
RUN npm -v
RUN cd /tmp ; npm pack brace-expansion@5.0.12 ; tar -xzf brace-expansion-5.0.12.tgz ;  rm -rf /usr/local/lib/node_modules/npm/node_modules/brace-expansion ; cp -a package   /usr/local/lib/node_modules/npm/node_modules/brace-expansion
RUN cd /tmp; npm pack undici@6.28.1 ;tar -xzf undici-6.28.1.tgz ; rm -rf /usr/local/lib/node_modules/npm/node_modules/undici ; cp -a package   /usr/local/lib/node_modules/npm/node_modules/undici
RUN cd /tmp ;  npm pack ip-address@latest ;  tar -xzf ip-address-*.tgz ;  rm -rf /usr/local/lib/node_modules/npm/node_modules/ip-address ;  cp -a package   /usr/local/lib/node_modules/npm/node_modules/ip-address
RUN cd /tmp ;  npm pack postcss-selector-parser@latest ;  tar -xzf postcss-selector-parser-*.tgz ;  rm -rf /usr/local/lib/node_modules/npm/node_modules/postcss-selector-parser ;  cp -a package   /usr/local/lib/node_modules/npm/node_modules/postcss-selector-parser

# RUN ln -s "$(which node)" "$(dirname "$(which node)")/nodejs"



# RUN mkdir -p /etc/apt/keyrings && \
#     curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
#     echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" \
#     | tee /etc/apt/sources.list.d/nodesource.list && \
#     apt-get update && \
#     apt-get install -y nodejs

# Default Scripts
# RUN wget https://raw.githubusercontent.com/dbca-wa/wagov_utils/main/wagov_utils/bin/default_script_installer.sh -O /tmp/default_script_installer.sh
# RUN chmod 755 /tmp/default_script_installer.sh
# RUN /tmp/default_script_installer.sh

FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu2604_base_latest as builder_base_ubuntu2604
MAINTAINER asi@dbca.wa.gov.au

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth

RUN apt-get clean
RUN apt-get update
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install --no-install-recommends -y curl wget git libmagic-dev gcc binutils libproj-dev gdal-bin python3 python3-venv python3-dev tzdata postgresql-client
# python3-setuptools rsyslog virtualenv python3-pip 
RUN apt-get install --no-install-recommends -y libpq-dev patch libreoffice
# RUN apt-get install --no-install-recommends -y postgresql-client mtr htop vim nano sudo sysstat 
RUN apt-get install --no-install-recommends -y bzip2 unzip jq
RUN apt-get install --no-install-recommends -y graphviz libgraphviz-dev pkg-config sqlite3 
RUN ln -s /usr/bin/python3 /usr/bin/python 

# RUN LATEST_URL=$(curl -sS -o /dev/null -w "%{url_effective}" https://github.com) && CHISEL_VERSION=${LATEST_URL##*/} && curl -sSL "https://github.com{CHISEL_VERSION}/chisel_${CHISEL_VERSION}_linux_amd64.tar.gz" | tar -xz -C /usr/local/bin/ chisel
# RUN mkdir /tmp/chisel; LATEST_TAG=$(wget -qO- https://api.github.com/repos/canonical/chisel/releases/latest | grep -oP '"tag_name": "\K[^"]+') ; VERSION="${LATEST_TAG#v}" ; wget https://github.com/canonical/chisel/releases/download/${LATEST_TAG}/chisel_${LATEST_TAG}_linux_amd64.tar.gz -O /tmp/chisel/chisel.tar.gz ; cd /tmp/chisel/ ; tar -xzvf chisel.tar.gz ; chiseldir=$(ls -1 /tmp/chisel/ | grep chisel_linux_amd64) ; cp /tmp/chisel/$chiseldir/chisel /bin/chisel ; chmod 755 /bin/chisel


# RUN chisel cut --release ubuntu-26.04 --root / \
#     base-files_base \
#     base-files_release-info \
#     libc6_libs

# Default Scripts
RUN wget https://raw.githubusercontent.com/dbca-wa/wagov_utils/main/wagov_utils/bin/default_script_installer.sh -O /tmp/default_script_installer.sh
RUN chmod 755 /tmp/default_script_installer.sh
RUN /tmp/default_script_installer.sh

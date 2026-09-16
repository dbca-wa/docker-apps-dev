FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu2604_base_latest as builder_base_ubuntu2604
MAINTAINER asi@dbca.wa.gov.au

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth

RUN sed 's/archive.ubuntu.com/azure.archive.ubuntu.com/g' /etc/apt/sources.list.d/ubuntu.sources > /etc/apt/sources.list.d/ubuntu.sources.azure
RUN mv /etc/apt/sources.list.d/ubuntu.sources.azure /etc/apt/sources.list.d/ubuntu.sources

RUN apt-get clean
RUN apt-get update
RUN apt install software-properties-common -y
# RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install --no-install-recommends -y curl wget git libmagic-dev gcc binutils libproj-dev tzdata postgresql-client
RUN apt-get install --no-install-recommends -y build-essential
RUN apt-get install --no-install-recommends -y libpq-dev patch 
# libreoffice
RUN apt-get install --no-install-recommends -y bzip2 unzip jq
RUN apt-get install --no-install-recommends -y graphviz libgraphviz-dev pkg-config sqlite3 

RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
RUN flatpak install flathub org.libreoffice.LibreOffice -y

# RUN chisel cut --release ubuntu-26.04 --root / \
#     base-files_base \
#     base-files_release-info \
#     libc6_libs
#RUN apt-get purge -y python3-httplib2
#RUN pip install --break-system-packages --upgrade httplib2

# coreutils is only a pointer and grype flagging even though the main package has been patched.  Temporary solution to match the package version to the main version
RUN sed -i '/^Package: coreutils$/,/^$/ s/^Version: 9\.5-1ubuntu2+0\.1\.0~ubuntu25$/Version: 9.7-3ubuntu2.1/' /var/lib/dpkg/status


RUN wget -qO /tmp/miniforge.sh  "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" && \
	 bash /tmp/miniforge.sh -b -p /usr/local/conda && \
	 rm /tmp/miniforge.sh
RUN echo 'export PATH="$PATH:/usr/local/conda/bin"' > /etc/profile.d/conda_path.sh
ENV PATH=/usr/local/conda/bin:$PATH
RUN ln -s /usr/local/conda/bin/python /usr/bin/python 
RUN mamba install -y -c conda-forge gdal=3.13 python=3.14 &&  mamba clean -afy
ENV GDAL_LIBRARY_PATH=/usr/local/conda/lib/libgdal.so
ENV GEOS_LIBRARY_PATH=/usr/local/conda/lib/libgeos_c.so
ENV OGR2OGR=/usr/local/conda/bin/ogr2ogr
RUN pip uninstall --yes conda-rattler-solver py-rattler

# Default Scripts
RUN wget https://raw.githubusercontent.com/dbca-wa/wagov_utils/main/wagov_utils/bin/default_script_installer.sh -O /tmp/default_script_installer.sh
RUN chmod 755 /tmp/default_script_installer.sh
RUN /tmp/default_script_installer.sh


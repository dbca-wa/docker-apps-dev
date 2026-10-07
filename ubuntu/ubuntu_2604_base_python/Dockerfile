FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu2604_base_latest as builder_base_ubuntu2604
MAINTAINER asi@dbca.wa.gov.au

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth

RUN sed 's/archive.ubuntu.com/azure.archive.ubuntu.com/g' /etc/apt/sources.list.d/ubuntu.sources > /etc/apt/sources.list.d/ubuntu.sources.azure
RUN mv /etc/apt/sources.list.d/ubuntu.sources.azure /etc/apt/sources.list.d/ubuntu.sources

RUN apt-get clean
RUN apt-get update
# RUN apt install software-properties-common -y
# RUN add-apt-repository ppa:deadsnakes/ppa
# RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install --no-install-recommends -y curl wget git libmagic-dev gcc binutils libproj-dev tzdata postgresql-client
RUN apt-get install --no-install-recommends -y build-essential run-one
RUN apt-get install --no-install-recommends -y libpq-dev patch 

RUN apt-get install --no-install-recommends -y bzip2 unzip jq
RUN apt-get install --no-install-recommends -y pkg-config sqlite3 
RUN apt-get install --no-install-recommends -y ca-certificates gpg
RUN apt-get install -y git autoconf automake libtool pkg-config flex bison cmake libffi-dev

RUN apt-get install --no-install-recommends -y \
    libxinerama1 \
    libxrender1 \
    libglib2.0-0 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libfontconfig1 \
    libsm6 \
    libice6 \
    libxt6


RUN apt-get install --no-install-recommends -y  \
    libnss3 \
    libnspr4 \
    libxslt1.1

RUN apt-get install --no-install-recommends -y  \
    libx11-xcb1 \
    libxcb-render0 \
    libxcb-shm0

# libdeflate
RUN export DEFLATE_VERSION=$(wget -qO- https://api.github.com/repos/ebiggers/libdeflate/releases/latest | grep '"tag_name"' | cut -d'"' -f4) ; wget https://github.com/ebiggers/libdeflate/archive/refs/tags/${DEFLATE_VERSION}.tar.gz -O /tmp/libdeflate.tar.gz
RUN cd /tmp/ ; tar -xzf libdeflate.tar.gz 
RUN cd /tmp/ ; cd libdeflate-* ; mkdir build ; cd build ; cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ; cmake --build . --parallel $(nproc) ; cmake --install .
RUN ldconfig
RUN ldconfig -p | grep libdeflate

# libtiff
RUN cd /tmp/ ; export TIFF_VERSION=$(wget -qO- https://download.osgeo.org/libtiff/ | grep -oP 'tiff-\K[0-9]+\.[0-9]+\.[0-9]+(?=\.tar\.gz)' | sort -V | tail -1) ; echo "Latest TIFF: $TIFF_VERSION" ; wget https://download.osgeo.org/libtiff/tiff-${TIFF_VERSION}.tar.gz ; tar -xzf tiff-${TIFF_VERSION}.tar.gz ; cd tiff-${TIFF_VERSION} ; ./configure --prefix=/usr/local ; make -j$(nproc) ; make install ; ldconfig  ; find /usr/local -name "libtiff.so*"


# coreutils is only a pointer and grype flagging even though the main package has been patched.  Temporary solution to match the package version to the main version
RUN sed -i '/^Package: coreutils$/,/^$/ s/^Version: 9\.5-1ubuntu2+0\.1\.0~ubuntu25$/Version: 9.7-3ubuntu2.1/' /var/lib/dpkg/status

RUN wget -qO /tmp/Python-3.14.8.tgz https://www.python.org/ftp/python/3.14.8/Python-3.14.8.tgz
RUN cd /tmp/ ; tar xzf Python-3.14.8.tgz
RUN cd /tmp/Python-3.14.8; ./configure --enable-optimizations --enable-shared
RUN cd /tmp/Python-3.14.8; make -j$(nproc)
RUN cd /tmp/Python-3.14.8; make altinstall
RUN ln -s /usr/local/bin/python3.14 /usr/bin/python
RUN ln -s /usr/local/bin/python3.14 /usr/bin/python3
RUN ln -s /usr/local/bin/pip3.14 /usr/bin/pip
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/python3.14.conf
RUN ldconfig
RUN python -V
RUN pip -V

RUN export VERSION=$(curl -fsSL "https://gitlab.com/api/v4/projects/4207231/releases" | jq -r '.[0].tag_name') ; wget -O /tmp/graphviz.tar.gz "https://gitlab.com/graphviz/graphviz/-/archive/${VERSION}/graphviz-${VERSION#*}/tar.gz"
RUN mkdir /tmp/graphviz/; cd /tmp/ ; tar xzf graphviz.tar.gz -C /tmp/graphviz
RUN cd "$(find /tmp/graphviz -mindepth 1 -maxdepth 1 -type d | head -n1)" ; ./autogen.sh 
RUN cd "$(find /tmp/graphviz -mindepth 1 -maxdepth 1 -type d | head -n1)" ; ./configure --prefix=/usr/local
RUN cd "$(find /tmp/graphviz -mindepth 1 -maxdepth 1 -type d | head -n1)" ; make -j$(nproc)
RUN cd "$(find /tmp/graphviz -mindepth 1 -maxdepth 1 -type d | head -n1)" ; make install
RUN dot -V
RUN pip install graphviz
# RUN pip install uno

# RUN wget -qO /tmp/miniforge.sh  "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" && \
	 # bash /tmp/miniforge.sh -b -p /usr/local/conda && \
	 # rm /tmp/miniforge.sh
# RUN echo 'export PATH="$PATH:/usr/local/conda/bin"' > /etc/profile.d/conda_path.sh
# ENV PATH=/usr/local/conda/bin:$PATH
# RUN ln -s /usr/local/conda/bin/python /usr/bin/python 
# RUN mamba install -y -c defaults python=3.14 python-graphviz 
# RUN mamba install -y -c conda-forge gdal=3.13 
# RUN mamba clean -afy
# RUN python -V
# ENV GDAL_LIBRARY_PATH=/usr/local/conda/lib/libgdal.so
# ENV GEOS_LIBRARY_PATH=/usr/local/conda/lib/libgeos_c.so
# ENV OGR2OGR=/usr/local/conda/bin/ogr2ogr

RUN export GDAL_VERSION=$(wget -qO- https://gdal.org/en/stable/download.html | grep -oP 'gdal-\K[0-9]+\.[0-9]+\.[0-9]+(?=\.tar\.gz)' | sort -u | head -n1) ;  wget "https://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz" ; tar -xzf gdal-${GDAL_VERSION}.tar.gz ; cd gdal-${GDAL_VERSION} ; mkdir build ; cd build ; cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ; cmake --build . -j$(nproc) ; cmake --install . ; ldconfig
RUN gdal-config --version
RUN gdalinfo --version

RUN export GEOS_VERSION=$(wget -qO- https://libgeos.org/usage/download/ | grep -oP 'geos-\K[0-9]+\.[0-9]+\.[0-9]+(?=\.tar\.bz2)' | head -n1) ; cd /tmp/; wget "https://download.osgeo.org/geos/geos-${GEOS_VERSION}.tar.bz2" ; tar -xjf "geos-${GEOS_VERSION}.tar.bz2"  ; cd "geos-${GEOS_VERSION}" ; mkdir build ; cd build ; cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ; cmake --build . -j$(nproc) ;  cmake --install . ; ldconfig
RUN geos-config --version
 
ENV GDAL_LIBRARY_PATH=/usr/local/lib/libgdal.so
ENV GEOS_LIBRARY_PATH=/usr/local/lib/libgeos_c.so
ENV OGR2OGR=/usr/local/bin/ogr2ogr

# RUN pip uninstall --yes conda-rattler-solver py-rattler

# install libreoffice
RUN curl -fsSL https://download.documentfoundation.org/libreoffice/stable/26.8.0/deb/x86_64/LibreOffice_26.8.0_Linux_x86-64_deb.tar.gz -o libreoffice.tar.gz \
    && tar -xvf libreoffice.tar.gz \
    && cd LibreOffice_26.8.0*_Linux_x86-64_deb/DEBS/ \
    && for file in *.deb; do \
         ar x "$file" data.tar.xz && tar -xJf data.tar.xz && rm data.tar.xz; \
       done \
    && mv opt/libreoffice* /opt/libreoffice \
    && ln -s /opt/libreoffice/program/soffice /usr/local/bin/libreoffice \
    && cd /tmp && rm -rf libreoffice.tar.gz LibreOffice_26.8.0*
RUN rm /opt/libreoffice/program/libpython3.13.so
RUN rm /opt/libreoffice/program/libpython3.13.so.1.0
# RUN ln -sf /usr/lib/x86_64-linux-gnu/libpython3.14.so.1.0 /opt/libreoffice/program/libpython3.13.so	
# RUN ln -sf /usr/lib/x86_64-linux-gnu/libpython3.14.so.1.0 /opt/libreoffice/program/libpython3.13.so.1.0
# RUN ln -sf /usr/local/conda/lib/libpython3.14.so.1.0 /opt/libreoffice/program/libpython3.13.so	
# RUN ln -sf /usr/local/conda/lib/libpython3.14.so.1.0 /opt/libreoffice/program/libpython3.13.so.1.0
RUN ln -sf /usr/local/lib/libpython3.14.so.1.0 /opt/libreoffice/program/libpython3.13.so	
RUN ln -sf /usr/local/lib/libpython3.14.so.1.0 /opt/libreoffice/program/libpython3.13.so.1.0

RUN rm /opt/libreoffice/program/python
RUN ln -s /usr/bin/python /opt/libreoffice/program/python

RUN echo "/opt/libreoffice/program" > $(python -c "import site; print(site.getsitepackages()[0])")/libreoffice.pth
ENV URE_BOOTSTRAP="vnd.sun.star.pathname:/opt/libreoffice/program/fundamentalrc" 

RUN /opt/libreoffice/program/python -m pip install unoserver

# Default Scripts
RUN wget https://raw.githubusercontent.com/dbca-wa/wagov_utils/main/wagov_utils/bin/default_script_installer.sh -O /tmp/default_script_installer.sh
RUN chmod 755 /tmp/default_script_installer.sh
RUN /tmp/default_script_installer.sh
RUN rm -rf /tmp/*


FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu2604_base_latest as builder_base_ubuntu2604
MAINTAINER asi@dbca.wa.gov.au

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth

RUN sed 's/archive.ubuntu.com/azure.archive.ubuntu.com/g' /etc/apt/sources.list.d/ubuntu.sources > /etc/apt/sources.list.d/ubuntu.sources.azure
RUN mv /etc/apt/sources.list.d/ubuntu.sources.azure /etc/apt/sources.list.d/ubuntu.sources

RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install --no-install-recommends -y curl wget git libmagic-dev gcc binutils libproj-dev tzdata postgresql-client build-essential run-one libpq-dev patch bzip2 unzip jq pkg-config ca-certificates gpg autoconf automake libtool pkg-config flex bison cmake libffi-dev
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
    libxt6 \ 
	libnss3 \
    libnspr4 \
    libxslt1.1 \	
	libx11-xcb1 \
    libxcb-render0 \
    libxcb-shm0 \
	libtool 

  
# libdeflate
RUN export DEFLATE_VERSION=$(wget -qO- https://api.github.com/repos/ebiggers/libdeflate/releases/latest | grep '"tag_name"' | cut -d'"' -f4) ; wget https://github.com/ebiggers/libdeflate/archive/refs/tags/${DEFLATE_VERSION}.tar.gz -O /tmp/libdeflate.tar.gz ; cd /tmp/ ; tar -xzf libdeflate.tar.gz ; cd /tmp/ ; cd libdeflate-* ; mkdir build ; cd build ; cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ; cmake --build . --parallel $(nproc) ; cmake --install . ; ldconfig ; ldconfig -p | grep libdeflate

# libtiff
RUN cd /tmp/ ; export TIFF_VERSION=$(wget -qO- https://download.osgeo.org/libtiff/ | grep -oP 'tiff-\K[0-9]+\.[0-9]+\.[0-9]+(?=\.tar\.gz)' | sort -V | tail -1) ; echo "Latest TIFF: $TIFF_VERSION" ; wget https://download.osgeo.org/libtiff/tiff-${TIFF_VERSION}.tar.gz ; tar -xzf tiff-${TIFF_VERSION}.tar.gz ; cd tiff-${TIFF_VERSION} ; ./configure --prefix=/usr/local ; make -j$(nproc) ; make install ; ldconfig  ; find /usr/local -name "libtiff.so*"
# libjepg
RUN cd /tmp ; export JPEG_VERSION=$(wget -qO- https://api.github.com/repos/libjpeg-turbo/libjpeg-turbo/releases/latest | grep '"tag_name"' | head -1 | sed -E 's/.*"([0-9.]+)".*/\1/') ; echo "Latest JPEG Turbo: $JPEG_VERSION" ; wget https://github.com/libjpeg-turbo/libjpeg-turbo/archive/refs/tags/${JPEG_VERSION}.tar.gz -O libjpeg-turbo-${JPEG_VERSION}.tar.gz ; tar -xzf libjpeg-turbo-${JPEG_VERSION}.tar.gz ; cd libjpeg-turbo-${JPEG_VERSION}; mkdir build ; cd build ; cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ;  make -j$(nproc) ; make install ; ldconfig ; find /usr/local -name "libjpeg*"
# libpng
RUN cd /tmp ; export PNG_VERSION=$(wget -qO- https://sourceforge.net/projects/libpng/rss?path=/libpng16 | grep -oPm1 'libpng-\K[0-9]+\.[0-9]+\.[0-9]+(?=\.tar\.xz)') ; echo "Latest libpng: $PNG_VERSION" ; wget https://downloads.sourceforge.net/project/libpng/libpng16/${PNG_VERSION}/libpng-${PNG_VERSION}.tar.xz ; tar -xf libpng-${PNG_VERSION}.tar.xz ; cd libpng-${PNG_VERSION} ; ./configure --prefix=/usr/local ; make -j$(nproc) ; make install ; ldconfig ; ldconfig -p | grep png
# zlib
RUN cd /tmp ; export ZLIB_VERSION=$(wget -qO- https://api.github.com/repos/madler/zlib/releases/latest | grep '"tag_name"' | cut -d '"' -f4) ; echo "Latest zlib: ${ZLIB_VERSION}" ; wget https://github.com/madler/zlib/archive/refs/tags/${ZLIB_VERSION}.tar.gz -O zlib-${ZLIB_VERSION}.tar.gz ; tar -xzf zlib-${ZLIB_VERSION}.tar.gz ; cd $(find /tmp -maxdepth 1 -type d -name 'zlib-*' | head -1) ; ./configure --prefix=/usr/local ; make -j$(nproc) ; make install ; ldconfig ; ldconfig -p | grep libz.so

# zstd
RUN cd /tmp ; export ZSTD_VERSION=$(wget -qO- https://api.github.com/repos/facebook/zstd/releases/latest | grep '"tag_name"' | cut -d '"' -f4) ; echo "Latest ZSTD: ${ZSTD_VERSION}" ; wget https://github.com/facebook/zstd/archive/refs/tags/${ZSTD_VERSION}.tar.gz -O zstd-${ZSTD_VERSION}.tar.gz ; tar -xzf zstd-${ZSTD_VERSION}.tar.gz ; cd zstd-${ZSTD_VERSION#v} ; make -j$(nproc) ; make install PREFIX=/usr/local ; ldconfig ; ldconfig -p | grep zstd
# liblzma
RUN cd /tmp ; export XZ_VERSION=$(wget -qO- https://api.github.com/repos/tukaani-project/xz/releases/latest | grep '"tag_name"' | cut -d '"' -f4) ; echo "Latest XZ: ${XZ_VERSION}" ; wget https://github.com/tukaani-project/xz/releases/download/${XZ_VERSION}/xz-${XZ_VERSION#v}.tar.gz ; tar -xzf xz-${XZ_VERSION#v}.tar.gz ; cd xz-${XZ_VERSION#v} ; ./configure --prefix=/usr/local ; make -j$(nproc) ; make install ; ldconfig ; ldconfig -p | grep lzma
# sqlite3 
RUN cd /tmp ; export YEAR=$(date +%Y) ; export CFLAGS="-O2 -DSQLITE_ENABLE_RTREE=1" ; export SQLITE_VERSION=$(wget -qO- https://www.sqlite.org/download.html | grep -oPm1 'sqlite-autoconf-\K[0-9]+') ; echo "SQLite version: $SQLITE_VERSION" ; wget https://www.sqlite.org/${YEAR}/sqlite-autoconf-${SQLITE_VERSION}.tar.gz ; tar -xzf sqlite-autoconf-${SQLITE_VERSION}.tar.gz ; cd sqlite-autoconf-${SQLITE_VERSION} ; ./configure --prefix=/usr/local ; make -j$(nproc) ; make install ; ldconfig ; sqlite3 --version ; ldconfig -p | grep sqlite3
# proj
RUN cd /tmp ; PROJ_VERSION=$(wget -qO- https://api.github.com/repos/OSGeo/PROJ/releases/latest | grep '"tag_name"' | cut -d '"' -f4 | sed 's/^v//') ; echo "Latest PROJ: ${PROJ_VERSION}" ; wget https://github.com/OSGeo/PROJ/releases/download/${PROJ_VERSION}/proj-${PROJ_VERSION}.tar.gz ; tar -xzf proj-${PROJ_VERSION}.tar.gz ; cd proj-${PROJ_VERSION} ; mkdir build ; cd build ; cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ; make -j$(nproc) ; make install ; ldconfig ; ldconfig -p | grep proj
# geos
RUN cd /tmp ; GEOS_VERSION=$(wget -qO- https://api.github.com/repos/libgeos/geos/releases/latest | grep '"tag_name"' | cut -d '"' -f4) ; echo "Latest GEOS: ${GEOS_VERSION}" ; wget https://github.com/libgeos/geos/archive/refs/tags/${GEOS_VERSION}.tar.gz -O geos-${GEOS_VERSION}.tar.gz ; tar -xzf geos-${GEOS_VERSION}.tar.gz ; cd geos-${GEOS_VERSION#v} ; mkdir build ; cd build ; cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ; make -j$(nproc) ; make install ; ldconfig ; geos-config --version
# lerc
RUN cd /tmp ; export LERC_VERSION=$(wget -qO- https://api.github.com/repos/Esri/lerc/releases/latest | grep '"tag_name"' | sed -E 's/.*"v?([^"]+)".*/\1/') ; wget -O lerc-${LERC_VERSION}.tar.gz https://github.com/Esri/lerc/archive/refs/tags/v${LERC_VERSION}.tar.gz ; tar -xzf lerc-${LERC_VERSION}.tar.gz ; cd "$(find . -maxdepth 1 -type d -name 'lerc-*' | head -n 1)" ; mkdir build ; cd build ; cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ; make -j$(nproc) ; make install ; ldconfig
# expat
RUN cd /tmp; export export EXPAT_VERSION=$(wget -qO- https://api.github.com/repos/libexpat/libexpat/releases/latest | grep '"tag_name"' | sed -E 's/.*"R_([0-9_]+)".*/\1/' | tr '_' '.') ; wget -O expat-${EXPAT_VERSION}.tar.xz    https://github.com/libexpat/libexpat/releases/download/R_$(echo ${EXPAT_VERSION} | tr '.' '_')/expat-${EXPAT_VERSION}.tar.xz ; tar -xf expat-${EXPAT_VERSION}.tar.xz ; cd "$(find . -maxdepth 1 -type d -name "expat-${EXPAT_VERSION}*" | head -n 1)" ; mkdir -p build ; cd build ; cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON ; make -j$(nproc) ;  make install ; ldconfig
# libxml2
RUN cd /tmp ; export LIBXML2_BASE_URL="https://download.gnome.org/sources/libxml2" ; export LIBXML2_BRANCH=$(wget -qO- "${LIBXML2_BASE_URL}/" | grep -oE 'href="[0-9]+\.[0-9]+/"' | sed -E 's|href="([^"]+)/"|\1|' | sort -V |tail -n 1); export LIBXML2_VERSION=$(wget -qO- "${LIBXML2_BASE_URL}/${LIBXML2_BRANCH}/" | grep -oE 'libxml2-[0-9]+\.[0-9]+\.[0-9]+\.tar\.xz' | sed -E 's/^libxml2-//;s/\.tar\.xz$//' | sort -Vu | tail -n 1); echo "Branch: ${LIBXML2_BRANCH}" ; echo "Version: ${LIBXML2_VERSION}" ; wget -O "libxml2-${LIBXML2_VERSION}.tar.xz" "${LIBXML2_BASE_URL}/${LIBXML2_BRANCH}/libxml2-${LIBXML2_VERSION}.tar.xz" ;  tar -xf "libxml2-${LIBXML2_VERSION}.tar.xz" ;  export LIBXML2_SOURCE_DIR=$(    find /tmp  -maxdepth 1 -type d -name "libxml2-${LIBXML2_VERSION}" -print -quit) ; echo "Source directory: ${LIBXML2_SOURCE_DIR}" ;  test -n "${LIBXML2_SOURCE_DIR}" ; cmake -S "${LIBXML2_SOURCE_DIR}" -B "${LIBXML2_SOURCE_DIR}/build" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON -DLIBXML2_WITH_PYTHON=OFF -DLIBXML2_WITH_TESTS=OFF ; cmake --build "${LIBXML2_SOURCE_DIR}/build" --parallel "$(nproc)" ; cmake --install "${LIBXML2_SOURCE_DIR}/build" ; echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf ;ldconfig
# libssl and libcrypto
# RUN cd /tmp ; export OPENSSL_VERSION=$(wget -qO- https://api.github.com/repos/openssl/openssl/releases/latest | grep '"tag_name"' | sed -E 's/.*"openssl-([^"]+)".*/\1/') ; wget -O openssl-${OPENSSL_VERSION}.tar.gz https://github.com/openssl/openssl/releases/download/openssl-${OPENSSL_VERSION}/openssl-${OPENSSL_VERSION}.tar.gz ; tar -xzf openssl-${OPENSSL_VERSION}.tar.gz ; cd "$(find . -maxdepth 1 -type d -name "openssl-${OPENSSL_VERSION}*" | head -n1)";  ./Configure --prefix=/usr/local  --openssldir=/usr/local/ssl shared linux-x86_64; make -j$(nproc); make install; echo "/usr/local/lib64" > /etc/ld.so.conf.d/openssl.conf ; echo "/usr/local/lib" >> /etc/ld.so.conf.d/openssl.conf ; ldconfig
# libwebp
RUN cd /tmp ; export WEBP_TAG=$(wget -qO- "https://api.github.com/repos/webmproject/libwebp/tags?per_page=100" |    grep -oE '"name":[[:space:]]*"v?[0-9]+\.[0-9]+\.[0-9]+"' |     sed -E 's/.*"([^"]+)"/\1/' |     sort -V |    tail -n 1); test -n "${WEBP_TAG}" ; echo "Latest libwebp tag: ${WEBP_TAG}" ; wget -O "libwebp-${WEBP_TAG#v}.tar.gz" "https://codeload.github.com/webmproject/libwebp/tar.gz/refs/tags/${WEBP_TAG}" ; tar -xzf "libwebp-${WEBP_TAG#v}.tar.gz"; export WEBP_SOURCE_DIR=$(find /tmp -maxdepth 1 -type d -name "libwebp-${WEBP_TAG#v}" -print -quit); test -n "${WEBP_SOURCE_DIR}" ; cmake sS "${WEBP_SOURCE_DIR}" -B "${WEBP_SOURCE_DIR}/build" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON ; cmake --build "${WEBP_SOURCE_DIR}/build" --parallel "$(nproc)" ; cmake --install "${WEBP_SOURCE_DIR}/build" ; echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf; ldconfig
# libopenjp2
RUN cd /tmp ; OPENJPEG_TAG=$(wget -qO- "https://api.github.com/repos/uclouvain/openjpeg/tags?per_page=100" | grep -oE '"name":[[:space:]]*"v?[0-9]+\.[0-9]+\.[0-9]+"' | sed -E 's/.*"([^"]+)"/\1/' | sort -V | tail -n1); echo "OpenJPEG: ${OPENJPEG_TAG}"; wget -O openjpeg.tar.gz  "https://codeload.github.com/uclouvain/openjpeg/tar.gz/refs/tags/${OPENJPEG_TAG}" ; tar -xzf openjpeg.tar.gz ; OPENJPEG_DIR=$(find /tmp -maxdepth 1 -type d -name "openjpeg-*" | head -n1) ; cd "$OPENJPEG_DIR" ; cmake -S .     -B build     -DCMAKE_BUILD_TYPE=Release     -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON ;cmake --build build --parallel "$(nproc)"; cmake --install build ; echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf ; ldconfig
# libheif
RUN cd /tmp; LIBHEIF_TAG=$(wget -qO- "https://api.github.com/repos/strukturag/libheif/tags?per_page=100" | grep -oE '"name":[[:space:]]*"v?[0-9]+\.[0-9]+\.[0-9]+"' |  sed -E 's/.*"([^"]+)"/\1/' |  sort -V | tail -n1); echo "libheif: ${LIBHEIF_TAG}" ; wget -O libheif.tar.gz     "https://codeload.github.com/strukturag/libheif/tar.gz/refs/tags/${LIBHEIF_TAG}" ; tar -xzf libheif.tar.gz ; LIBHEIF_DIR=$(find /tmp -maxdepth 1 -type d -name "libheif-*" | head -n1); cmake -S "${LIBHEIF_DIR}" -B "${LIBHEIF_DIR}/build" -DCMAKE_BUILD_TYPE=Release     -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON; cmake --build "${LIBHEIF_DIR}/build" --parallel "$(nproc)"; cmake --install "${LIBHEIF_DIR}/build" ; echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf ; ldconfig
# libiconv
RUN cd /tmp; ICONV_VERSION=$(wget -qO- https://ftp.gnu.org/pub/gnu/libiconv/ |    grep -oE 'libiconv-[0-9]+\.[0-9]+(\.[0-9]+)?\.tar\.gz' |    sed -E 's/^libiconv-//;s/\.tar\.gz$//' |    sort -V |    tail -n1); echo "libiconv version: ${ICONV_VERSION}" ; wget "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-${ICONV_VERSION}.tar.gz"; tar -xzf "libiconv-${ICONV_VERSION}.tar.gz" ; cd "$(find . -maxdepth 1 -type d -name "libiconv-${ICONV_VERSION}*" | head -n1)"; ./configure --prefix=/usr/local ; make -j$(nproc) ;make install ;echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf ; ldconfig
# libarchive
RUN cd /tmp; LIBARCHIVE_TAG=$(wget -qO- "https://api.github.com/repos/libarchive/libarchive/tags?per_page=100" |    grep -oE '"name":[[:space:]]*"v?[0-9]+\.[0-9]+\.[0-9]+"' |    sed -E 's/.*"([^"]+)"/\1/' |    sort -V |    tail -n1); echo "libarchive: ${LIBARCHIVE_TAG}"; wget -O libarchive.tar.gz  "https://codeload.github.com/libarchive/libarchive/tar.gz/refs/tags/${LIBARCHIVE_TAG}" ; tar -xzf libarchive.tar.gz ; LIBARCHIVE_DIR=$(find /tmp -maxdepth 1 -type d -name "libarchive-*" | head -n1) ; cmake -S "${LIBARCHIVE_DIR}" -B "${LIBARCHIVE_DIR}/build" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON; cmake --build "${LIBARCHIVE_DIR}/build" --parallel "$(nproc)" ; cmake --install "${LIBARCHIVE_DIR}/build" ; echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf ; ldconfig
# giflib
RUN cd /tmp; export GIFLIB_VERSION=$(wget -qO- https://sourceforge.net/projects/giflib/files/ | grep -oE 'giflib-[0-9]+\.[0-9]+\.[0-9]+' | sed 's/giflib-//' | sort -V |   tail -n1); echo "giflib version: ${GIFLIB_VERSION}" ; wget https://sourceforge.net/projects/giflib/files/giflib-${GIFLIB_VERSION}.tar.gz/download -O giflib-${GIFLIB_VERSION}.tar.gz; tar -xzf "giflib-${GIFLIB_VERSION}.tar.gz" ; cd "$(find . -maxdepth 1 -type d -name "giflib-${GIFLIB_VERSION}*" | head -n1)"; make -j$(nproc) ;  make PREFIX=/usr/local install; echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf ;ldconfig
# freexl
# RUN cd /tmp && export FREEXL_VERSION=$(wget -qO- https://www.gaia-gis.it/fossil/freexl/index | grep -oE 'freexl-[0-9]+\.[0-9]+\.[0-9]+\.tar\.gz' | sed -E 's/^freexl-//;s/\.tar\.gz$//' | sort -V | tail -n1) && wget "https://www.gaia-gis.it/gaia-sins/freexl-${FREEXL_VERSION}.tar.gz" && tar xzf "freexl-${FREEXL_VERSION}.tar.gz" && cd "freexl-${FREEXL_VERSION}" && ./configure --prefix=/usr/local && make -j"$(nproc)" && make install && ldconfig
# libspatialite
# RUN cd /tmp && SPATIALITE_FILE=$(wget -qO- https://www.gaia-gis.it/fossil/libspatialite/index | grep -oE 'libspatialite-[0-9]+\.[0-9]+\.[0-9]+\.tar\.gz' | sort -V | tail -n1) && wget "https://www.gaia-gis.it/gaia-sins/libspatialite-sources/${SPATIALITE_FILE}" && tar xzf "${SPATIALITE_FILE}" && cd "${SPATIALITE_FILE%.tar.gz}" && ./configure --prefix=/usr/local && make -j$(nproc) && make install && ldconfig

# coreutils is only a pointer and grype flagging even though the main package has been patched.  Temporary solution to match the package version to the main version
RUN sed -i '/^Package: coreutils$/,/^$/ s/^Version: 9\.5-1ubuntu2+0\.1\.0~ubuntu25$/Version: 9.7-3ubuntu2.1/' /var/lib/dpkg/status

RUN wget -qO /tmp/Python-3.14.8.tgz https://www.python.org/ftp/python/3.14.8/Python-3.14.8.tgz
RUN cd /tmp/ ; tar xzf Python-3.14.8.tgz ; cd /tmp/Python-3.14.8; ./configure --enable-optimizations --enable-shared; cd /tmp/Python-3.14.8; make -j$(nproc); cd /tmp/Python-3.14.8; make altinstall 
RUN ln -s /usr/local/bin/python3.14 /usr/bin/python ; ln -s /usr/local/bin/python3.14 /usr/bin/python3 ; ln -s /usr/local/bin/pip3.14 /usr/bin/pip
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/python3.14.conf
RUN ldconfig ; python -V; pip -V

RUN export VERSION=$(curl -fsSL "https://gitlab.com/api/v4/projects/4207231/releases" | jq -r '.[0].tag_name') ; wget -O /tmp/graphviz.tar.gz "https://gitlab.com/graphviz/graphviz/-/archive/${VERSION}/graphviz-${VERSION#*}/tar.gz"
#RUN mkdir /tmp/graphviz/; cd /tmp/ ; tar xzf graphviz.tar.gz -C /tmp/graphviz ; cd "$(find /tmp/graphviz -mindepth 1 -maxdepth 1 -type d | head -n1)" ; ./autogen.sh  ; cd "$(find /tmp/graphviz -mindepth 1 -maxdepth 1 -type d | head -n1)" ; ./configure --prefix=/usr/local ; cd "$(find /tmp/graphviz -mindepth 1 -maxdepth 1 -type d | head -n1)" ; make -j$(nproc) ; cd "$(find /tmp/graphviz -mindepth 1 -maxdepth 1 -type d | head -n1)" ; make install
RUN mkdir /tmp/graphviz/; cd /tmp/ ; tar xzf graphviz.tar.gz -C /tmp/graphviz ; cd "$(find /tmp/graphviz -mindepth 1 -maxdepth 1 -type d | head -n1)" ; ./autogen.sh  ; ./configure --prefix=/usr/local ; make -j$(nproc) ;  make install
RUN dot -V
RUN pip install graphviz

RUN export GDAL_VERSION=$(wget -qO- https://gdal.org/en/stable/download.html | grep -oP 'gdal-\K[0-9]+\.[0-9]+\.[0-9]+(?=\.tar\.gz)' | sort -u | head -n1) ;  wget "https://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz" ; tar -xzf gdal-${GDAL_VERSION}.tar.gz ; cd gdal-${GDAL_VERSION} ; mkdir build ; cd build ; cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ; cmake --build . -j$(nproc) ; cmake --install . ; ldconfig ; gdal-config --version ; gdalinfo --version
RUN export GEOS_VERSION=$(wget -qO- https://libgeos.org/usage/download/ | grep -oP 'geos-\K[0-9]+\.[0-9]+\.[0-9]+(?=\.tar\.bz2)' | head -n1) ; cd /tmp/; wget "https://download.osgeo.org/geos/geos-${GEOS_VERSION}.tar.bz2" ; tar -xjf "geos-${GEOS_VERSION}.tar.bz2"  ; cd "geos-${GEOS_VERSION}" ; mkdir build ; cd build ; cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ; cmake --build . -j$(nproc) ;  cmake --install . ; ldconfig ; geos-config --version

ENV GDAL_LIBRARY_PATH=/usr/local/lib/libgdal.so
ENV GEOS_LIBRARY_PATH=/usr/local/lib/libgeos_c.so
ENV OGR2OGR=/usr/local/bin/ogr2ogr

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
RUN rm /opt/libreoffice/program/libpython3.13.so ; rm /opt/libreoffice/program/libpython3.13.so.1.0
RUN ln -sf /usr/local/lib/libpython3.14.so.1.0 /opt/libreoffice/program/libpython3.13.so ; ln -sf /usr/local/lib/libpython3.14.so.1.0 /opt/libreoffice/program/libpython3.13.so.1.0

RUN rm /opt/libreoffice/program/python ; ln -s /usr/bin/python /opt/libreoffice/program/python ; echo "/opt/libreoffice/program" > $(python -c "import site; print(site.getsitepackages()[0])")/libreoffice.pth

ENV URE_BOOTSTRAP="vnd.sun.star.pathname:/opt/libreoffice/program/fundamentalrc" 

RUN /opt/libreoffice/program/python -m pip install unoserver

# Default Scripts
RUN wget https://raw.githubusercontent.com/dbca-wa/wagov_utils/main/wagov_utils/bin/default_script_installer.sh -O /tmp/default_script_installer.sh ; chmod 755 /tmp/default_script_installer.sh; /tmp/default_script_installer.sh ; rm -rf /tmp/*


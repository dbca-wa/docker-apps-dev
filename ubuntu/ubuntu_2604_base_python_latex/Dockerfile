FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu_2604_base_python as builder_base_ubuntu2604_python
MAINTAINER asi@dbca.wa.gov.au

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth

RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y

# Install nodejs
RUN update-ca-certificates
RUN apt-get install --no-install-recommends -y libffi-dev libyaml-dev

RUN cd /tmp && \
    wget -q https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    cd install-tl-* && \
    printf '%s\n' \
      'selected_scheme scheme-small' \
      'TEXDIR /opt/texlive' \
      'TEXMFLOCAL /opt/texlive/texmf-local' \
      'TEXMFSYSCONFIG /opt/texlive/texmf-config' \
      'TEXMFSYSVAR /opt/texlive/texmf-var' \
      > texlive.profile && \
    ./install-tl -profile texlive.profile && \
    /opt/texlive/bin/*/tlmgr install \
      latexmk \
      collection-latexextra \
      collection-latex \
      collection-latexrecommended \
      collection-fontsrecommended \
      collection-latexextra \
      collection-langenglish && \      
      rm -rf /tmp/install-tl*

ENV PATH="/opt/texlive/bin/x86_64-linux:${PATH}"

RUN which pdflatex && \
    pdflatex --version && \
    latexmk --version
      

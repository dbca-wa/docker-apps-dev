# Prepare the base environment.
FROM ubuntu:24.04 as builder_base_docker
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV PRODUCTION_EMAIL=True
ENV SECRET_KEY="ThisisNotRealKey"
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
#RUN apt-get install --no-install-recommends -y texlive-full
RUN apt-get install --no-install-recommends -y texlive-bibtex-extra texlive-binaries texlive-extra-utils texlive-fonts-extra texlive-formats-extra texlive-humanities texlive-latex-base texlive-latex-extra texlive-latex-recommended texlive-luatex texlive-metapost texlive-pictures texlive-plain-generic texlive-pstricks texlive-publishers texlive-science texlive-xetex

WORKDIR /tmp
COPY timezone /etc/timezone
ENV TZ=Australia/Perth
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY startup.sh /
RUN chmod 755 /startup.sh
RUN apt-get clean
EXPOSE 8080
CMD ["/startup.sh"]

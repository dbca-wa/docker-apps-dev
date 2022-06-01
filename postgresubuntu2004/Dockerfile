# Prepare the base environment.
FROM ubuntu:20.04 as builder_base_docker
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV PRODUCTION_EMAIL=True
ENV SECRET_KEY="ThisisNotRealKey"
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y  wget git postgresql postgresql-12-postgis-3 postgresql-12-postgis-3-scripts
RUN apt-get install --no-install-recommends -y  net-tools vim nano telnet ssh
WORKDIR /app
COPY timezone /etc/timezone
ENV TZ=Australia/Perth
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY boot.sh /
COPY create-new-postgres.sh /app/
RUN chmod 755 /boot.sh
EXPOSE 5432 
CMD ["/boot.sh"]

# Prepare the base environment.
FROM ubuntu:24.04 as builder_base_docker
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV PRODUCTION_EMAIL=True
ENV SECRET_KEY="ThisisNotRealKey"
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
# RUN apt-get install --no-install-recommends -y curl ca-certificates
# install direct from postgres
# RUN install -d /usr/share/postgresql-common/pgdg
# RUN curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
# RUN echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
# RUN apt-get update
RUN apt install -y postgresql-common
RUN /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh

RUN apt-get install --no-install-recommends -y  wget git postgresql postgresql-16-postgis-3 postgresql-16-postgis-3-scripts
RUN apt-get install --no-install-recommends -y  net-tools vim nano telnet ssh
WORKDIR /app
COPY timezone /etc/timezone
ENV TZ=Australia/Perth
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY boot.sh /
COPY create-new-postgres.sh /app/
RUN mkdir /app/tools
COPY tools/* /app/tools/
RUN chmod 755 /app/tools/*.sh
RUN chmod 755 /boot.sh
RUN chmod 755 /app/create-new-postgres.sh
EXPOSE 5432 
CMD ["/boot.sh"]

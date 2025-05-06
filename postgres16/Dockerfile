# Prepare the base environment.
FROM postgres:16 as builder_base_docker
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV PRODUCTION_EMAIL=True
ENV SECRET_KEY="ThisisNotRealKey"
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y vim net-tools telnet procps wget ca-certificates
RUN apt-get install --no-install-recommends -y postgresql-16-postgis-3 postgresql-16-postgis-3-scripts

# Default Scripts
RUN wget https://raw.githubusercontent.com/dbca-wa/wagov_utils/main/wagov_utils/bin/default_script_installer.sh -O /tmp/default_script_installer.sh
RUN chmod 755 /tmp/default_script_installer.sh
RUN /tmp/default_script_installer.sh

# Set Terminal Prompt
RUN echo 'if ! [ -n "${SUDO_USER}" -a -n "${SUDO_PS1}" ]; then' >> /etc/bash.bashrc
RUN echo "export PS1='\[\e[0;31mdev:\e[0;32m \u@\h:~ \e[0;34m\W\$\e\[\e[0m\] '" >> /etc/bash.bashrc
RUN echo "fi" >> /etc/bash.bashrc

COPY set_hba.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/set_hba.sh
RUN echo "/usr/local/bin/set_hba.sh" >> /usr/local/bin/docker-entrypoint.sh


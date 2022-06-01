#!/bin/bash
# this is for the purpose of creating a new postgres on a new data mount. (first time setup)

cp -Rp /var/lib/postgresql-docker-version /data/postgresql-lib/
cp -Rp /etc/postgresql-docker-version /data/postgresql-etc
cp -Rp /etc/postgresql-common-docker-version /data/postgresql-common-etc
cp -Rp /var/log/postgresql-docker-version /data/postgresql-log
echo "Copied postgres files to shared directory"

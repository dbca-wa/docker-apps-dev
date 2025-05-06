#!/bin/bash

# Check if postgres rules exist
if grep -q "127.0.0.1/32    scram-sha-256" /var/lib/postgresql/data/pgdata/pg_hba.conf; then
  echo "172.17.0.1/8 exists";
else
  echo "host    all             all             127.0.0.1/32            scram-sha-256" >> /var/lib/postgresql/data/pgdata/pg_hba.conf
fi

if grep -q "100.112.0.0/16  scram-sha-256" /var/lib/postgresql/data/pgdata/pg_hba.conf; then
  echo "100.112.0.0/16 exists";
else
  echo "host    all             all             100.112.0.1/16            scram-sha-256" >> /var/lib/postgresql/data/pgdata/pg_hba.conf
fi

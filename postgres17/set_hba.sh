#!/bin/bash

# Check if postgres rules exist
if grep -q "#127.0.0.1/32 host access" /var/lib/postgresql/data/pgdata/pg_hba.conf; then
  echo "127.0.0.1/32 exists";
else
  echo "host    all             all             127.0.0.1/32            scram-sha-256 #127.0.0.1/32 host access" >> /var/lib/postgresql/data/pgdata/pg_hba.conf
fi

if grep -q "#100.112.0.1/16 host access" /var/lib/postgresql/data/pgdata/pg_hba.conf; then
  echo "100.112.0.0/16 exists";
else
  echo "host    all             all             100.112.0.1/16            scram-sha-256 #100.112.0.1/16 host access" >> /var/lib/postgresql/data/pgdata/pg_hba.conf
fi

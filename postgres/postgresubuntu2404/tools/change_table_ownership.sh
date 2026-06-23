#!/bin/bash

NEWOWNER=$1
DATBASE=$2

for tbl in `psql -qAt -c "select tablename from pg_tables where schemaname = 'public';" $DATBASE` ; do  psql -c "alter table \"$tbl\" owner to $NEWOWNER " $DATBASE ; done

for tbl in `psql -qAt -c "select sequence_name from information_schema.sequences where sequence_schema = 'public';" $DATBASE` ; do  psql -c "alter sequence \"$tbl\" owner to $NEWOWNER" $DATBASE ; done

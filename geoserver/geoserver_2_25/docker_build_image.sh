#!/bin/bash

date_var=$(date +%Y.%m.%d.%H.%M%S)
dockerrepo="appsteam-geoserver"
echo "Building $date_var"
#docker logout
docker image build --tag  dbcawa/$dockerrepo:2_25_latest . ;
docker tag dbcawa/$dockerrepo:2_25_latest dbcawa/$dockerrepo:2_25_$date_var;
docker image push dbcawa/$dockerrepo:2_25_latest;
docker image push dbcawa/$dockerrepo:2_25_$date_var;


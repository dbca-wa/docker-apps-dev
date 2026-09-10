#!/bin/bash

echo "Scanning Image $DOCKER_IMAGE"
skopeo copy docker://$DOCKER_IMAGE docker-archive:/tmp/dockerimage-export.tar
mkdir /tmp/dockerimage/


tar -xvof /tmp/dockerimage-export.tar -C /tmp/dockerimage/
mkdir /tmp/dockerimage/uncompressed
cd   /tmp/dockerimage/

for f in *.tar; do tar -xvof "$f" -C /tmp/dockerimage/uncompressed/; done

cd /tmp

mkdir /tmp/scans
# syft dir:/tmp/dockerimage/uncompressed/ -o cyclonedx-json="/tmp/scans/sbom.json"
# create sbom but dont follow symlinks
syft dir:/tmp/dockerimage/uncompressed/ --base-path /tmp/dockerimage/uncompressed/ -o cyclonedx-json="/tmp/scans/sbom.json"



grype /tmp/scans/sbom.json --sort-by=severity --output=template --template=/app/assets/tsv.tmpl --file=/tmp/scans/vulnerabilities.csv

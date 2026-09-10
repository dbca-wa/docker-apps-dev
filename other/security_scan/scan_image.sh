#!/bin/bash

echo "Scanning Image $DOCKER_IMAGE Started"
skopeo copy docker://$DOCKER_IMAGE oci:/tmp/oci-image:latest
mkdir /tmp/scans
umoci unpack --rootless --image /tmp/oci-image:latest /tmp/flattened-bundle
syft dir:/tmp/flattened-bundle/rootfs/ --base-path /tmp/flattened-bundle/rootfs/ -o cyclonedx-json="/tmp/scans/sbom.json"
grype /tmp/scans/sbom.json --sort-by=severity --output=template --template=/app/assets/tsv.tmpl --file=/tmp/scans/vulnerabilities.csv
echo "Scanning Image $DOCKER_IMAGE Completed"

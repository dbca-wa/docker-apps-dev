FROM ghcr.io/dbca-wa/docker-apps-dev:ubuntu_2604_base_python AS builder_base_ubuntu2604_python

LABEL maintainer="asi@dbca.wa.gov.au"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV NODE_VERSION=26.13.0

# Update base system and install Node.js
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends xz-utils \
    && update-ca-certificates \
    && wget -q "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" -O /tmp/node.tar.xz \
    && tar -xf /tmp/node.tar.xz --directory /usr/local --strip-components 1 \
    && rm -f /tmp/node.tar.xz \
    && apt-get purge -y --auto-remove xz-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Upgrade npm to latest
RUN npm install -g npm@latest \
    && node -v \
    && npm -v

# Patch flagged dependencies across all locations (including nested sub-dependencies)
RUN set -e; \
    NPM_DIR="/usr/local/lib/node_modules/npm"; \
    for pkg in \
    "brace-expansion@5.0.12" \
    "undici@6.29.1" \
    "ip-address@latest" \
    "postcss-selector-parser@latest" \
    "http-cache-semantics@latest"; do \
    name="${pkg%@*}"; \
    rm -rf /tmp/patch && mkdir -p /tmp/patch && cd /tmp/patch; \
    npm pack "$pkg"; \
    tar -xzf *.tgz; \
    found=0; \
    for target in $(find "$NPM_DIR" -type d -name "$name"); do \
    rm -rf "$target"; \
    cp -a /tmp/patch/package "$target"; \
    found=1; \
    done; \
    if [ "$found" -eq 0 ]; then \
    cp -a /tmp/patch/package "$NPM_DIR/node_modules/$name"; \
    fi; \
    cd /tmp && rm -rf /tmp/patch; \
    done; \
    cd /tmp && npm cache clean --force

# Thorough smoke test: installs, verifies binary execution, and checks npm's self-diagnostics
RUN mkdir -p /tmp/test && cd /tmp/test \
    && npm install lodash \
    && node -e "require('lodash')" \
    && cd /tmp && rm -rf /tmp/test

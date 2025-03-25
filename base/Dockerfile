ARG VARIANT=dev-22
ARG EXTRA_NODE_VERSION=22
FROM mcr.microsoft.com/devcontainers/typescript-node:dev-22

# OS Packages
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends jq wget 

# [NVM] Install a version of Node.js
#RUN su node -c "source /usr/local/share/nvm/nvm.sh && nvm install ${EXTRA_NODE_VERSION}"

# dotenvx
RUN su node -c "npm install -g @dotenvx/dotenvx"

# doppler
RUN su node -c '(curl -Ls --tlsv1.2 --proto "=https" --retry 3 https://cli.doppler.com/install.sh || wget -t 3 -qO- https://cli.doppler.com/install.sh) | sudo sh'

# test doppler + dotenvx
RUN su node -c "doppler --version" 
RUN su node -c "dotenvx --version"
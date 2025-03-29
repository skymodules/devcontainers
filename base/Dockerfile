ARG TAG="dev-22"
ARG IMAGE="mcr.microsoft.com/devcontainers/typescript-node"
ARG VSCODE_USER="vscode"

FROM ${IMAGE}:${TAG}

# -----------------------------------
# Root setup
# -----------------------------------
USER root

# OS packages
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends jq wget curl git gnupg pass

# Prepare user scripts
RUN mkdir -p /home/${VSCODE_USER}/tempx/
COPY install.sh /home/${VSCODE_USER}/install.sh
COPY install-hashicorp.sh /home/${VSCODE_USER}/install-hashicorp.sh
COPY shell.sh /home/${VSCODE_USER}/shell.sh

# Make scripts executable
RUN chmod +x /home/${VSCODE_USER}/install.sh \
    && chmod +x /home/${VSCODE_USER}/install-hashicorp.sh \
    && chmod +x /home/${VSCODE_USER}/shell.sh \
    && chown ${VSCODE_USER}:${VSCODE_USER} /usr/local/bin

# -----------------------------------
# Node.js tooling (doppler + dotenvx)
# -----------------------------------
RUN su node -c "npm install -g @dotenvx/dotenvx"
RUN su node -c '(curl -Ls --tlsv1.2 --proto "=https" --retry 3 https://cli.doppler.com/install.sh || wget -t 3 -qO- https://cli.doppler.com/install.sh) | sudo sh'
RUN su node -c "doppler --version"
RUN su node -c "dotenvx --version"

# -----------------------------------
# Bats installation
# -----------------------------------
RUN git clone https://github.com/bats-core/bats-core.git /opt/bats \
    && /opt/bats/install.sh /usr/local

# -----------------------------------
# Tool installation (as vscode)
# -----------------------------------
USER ${VSCODE_USER}
WORKDIR /workspace
RUN mkdir -p /workspace/temp
WORKDIR /workspace/temp

RUN /home/${VSCODE_USER}/install.sh
RUN trunk --version

RUN /home/${VSCODE_USER}/install-hashicorp.sh vault
RUN vault --version

RUN /home/${VSCODE_USER}/install-hashicorp.sh terraform
RUN terraform --version

RUN doppler --version 
RUN dotenvx --version
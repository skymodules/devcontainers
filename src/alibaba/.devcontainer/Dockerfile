ARG TAG="dev-22"
ARG IMAGE="mcr.microsoft.com/devcontainers/typescript-node"
ARG VSCODE_USER="vscode"

FROM ${IMAGE}:${TAG}

COPY shell.sh /home/${VSCODE_USER}/shell.sh
RUN ls -l /home/${VSCODE_USER}/ && chmod +x /home/${VSCODE_USER}/shell.sh
RUN chown ${VSCODE_USER}:${VSCODE_USER} /usr/local/bin
# syntax=docker/dockerfile:1.4

# [OCI] Base image metadata (OCI Annotation: org.opencontainers.image.base.name)
ARG IMAGE="mcr.microsoft.com/devcontainers/typescript-node"
ARG TAG="dev-22"
# [OCI] Base image
FROM ${IMAGE}:${TAG}

# [OCI] Author and description (can be overridden at build time using --label)
LABEL org.opencontainers.image.title="DevContainer for TypeScript Node"
LABEL org.opencontainers.image.description="A development container for TypeScript and Node.js using Microsoft's devcontainers image."
LABEL org.opencontainers.image.version="${TAG}"
LABEL org.opencontainers.image.authors="Your Name <your.email@example.com>"
LABEL org.opencontainers.image.url="https://example.com/devcontainer"
LABEL org.opencontainers.image.source="https://github.com/your-org/devcontainer-typescript-node"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.base.name="${IMAGE}:${TAG}"

# Set build-time variable
ARG VSCODE_USER="vscode"

# [OCI] Copy shell script to user's home directory
COPY shell.sh /home/${VSCODE_USER}/shell.sh

# [OCI] Set file permissions and ownership
RUN chmod +x /home/${VSCODE_USER}/shell.sh \
 && chown ${VSCODE_USER}:${VSCODE_USER} /home/${VSCODE_USER}/shell.sh \
 && chown ${VSCODE_USER}:${VSCODE_USER} /usr/local/bin

# [OCI] Default user context (optional, if runtime expects this user)
USER ${VSCODE_USER}

# [OCI] Default entrypoint or CMD (optional for devcontainers)
# CMD ["bash"]


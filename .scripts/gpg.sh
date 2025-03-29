#!/usr/bin/env bash

set -euo pipefail

# Required environment variables
: "${GH_USERNAME:?Must provide GH_USERNAME env var}"
: "${GH_TOKEN:?Must provide GH_TOKEN env var}"

# Constants
GPG_KEY_NAME="Docker Automation"
GPG_KEY_EMAIL="docker-bot@ghcr"
GPG_KEY_COMMENT="Auto Generated Key $(date +%s)"
GPG_KEY_PASSPHRASE=""
DOCKER_CONFIG_DIR="$HOME/.docker"

echo "Installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y gnupg2 pass docker.io

echo "Creating GPG batch config..."
GPG_BATCH_FILE=$(mktemp)
cat >"$GPG_BATCH_FILE" <<EOF
%no-protection
Key-Type: default
Key-Length: 4096
Subkey-Type: default
Name-Real: $GPG_KEY_NAME
Name-Comment: $GPG_KEY_COMMENT
Name-Email: $GPG_KEY_EMAIL
Expire-Date: 0
%commit
EOF

echo "Generating GPG key..."
gpg --batch --gen-key "$GPG_BATCH_FILE"
rm -f "$GPG_BATCH_FILE"

echo "Fetching GPG key ID..."
GPG_KEY_ID=$(gpg --list-secret-keys --with-colons "$GPG_KEY_EMAIL" | awk -F: '/^sec/ {print $5; exit}')

if [ -z "$GPG_KEY_ID" ]; then
    echo "Failed to find generated GPG key."
    exit 1
fi

echo "Initializing pass with GPG key..."
pass init "$GPG_KEY_ID"

echo "Configuring Docker to use pass credential store..."
mkdir -p "$DOCKER_CONFIG_DIR"
echo '{ "credsStore": "pass" }' >"$DOCKER_CONFIG_DIR/config.json"

echo "Logging in to ghcr.io with Docker..."
echo "$GH_TOKEN" | docker login ghcr.io -u "$GH_USERNAME" --password-stdin

echo "✅ Docker login successful and credentials saved via pass"

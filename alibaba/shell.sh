# 🔐 SSH KEY
SSH_KEY_DIR="$HOME/.ssh"
SSH_KEY_FILE="$SSH_KEY_DIR/github_ssh_key"
GITHUB_USER=$(gh auth status 2>&1 | grep 'Logged in to github.com as' | awk '{print $6}')
HOSTNAME=$(hostname)
KEY_COMMENT="${GITHUB_USER}@${HOSTNAME}"

start_session() {
    # determine if we are logged into github and if not log in via TOKEN
    if [ -z "$GITHUB_USER" ]; then
        echo "Logging into GitHub..."
        gh auth login
    fi
}

main() {
    set -e # Exit immediately if any command fails
    echo "Starting session..." && start_session || exit 1

}

main "$@"

# 🔐 SSH KEY
SSH_KEY_DIR="$HOME/.ssh"
SSH_KEY_FILE="$SSH_KEY_DIR/github_ssh_key"
GITHUB_USER=$(gh auth status 2>&1 | grep 'Logged in to github.com as' | awk '{print $6}')
HOSTNAME=$(hostname)
KEY_COMMENT="${GITHUB_USER}@${HOSTNAME}"

start_session() {

}

main() {
    start_session();
}

main "$@"

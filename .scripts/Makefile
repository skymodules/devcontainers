.PHONY: setup/gpg
# setup gpg on the build machine
setup/gpg:
	@dotenvx run --quiet -f $(ENV_FILES) -- doppler run -- echo "Setting up gpg"
	@dotenvx run --quiet -f $(ENV_FILES) -- doppler run -- ./.scripts/gpg.sh
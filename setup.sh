#!/usr/bin/env bash

set -euo pipefail
readonly IFS=$'\n\t'

readonly FUNCTIONS="$PWD/ci/support/functions.sh"
readonly HOOKS_DIR="$PWD/ci/hooks"
readonly HOOKS=("commit-msg" "pre-commit" "pre-receive")

# Load colours and common functions
chmod +x "$FUNCTIONS"
# shellcheck source=/dev/null
source "$FUNCTIONS"

for hook in "${HOOKS[@]}"
do
    print_info "Activating $hook"
    chmod u+x "$HOOKS_DIR/$hook"
    print_info "Linking $hook"
    ln -sfv "$HOOKS_DIR/$hook" ".git/hooks/$hook" > /dev/null
done

print_info "Detecting OS"
# Check if OS is windows
if [[ "$(uname -s)" = *"MINGW64_NT"* ]]
then
    start "https://confluence.devops.jlr-apps.com/display/MAD/Development+Environment+Setup"
    start "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
elif [[ "$(uname -s)" = *"darwin"* ]]
then 
	open "https://confluence.devops.jlr-apps.com/display/MAD/Development+Environment+Setup" 
else
	xdg-open "https://confluence.devops.jlr-apps.com/display/MAD/Development+Environment+Setup" 2>/dev/null || \
	print_info "Dev env setup: https://confluence.devops.jlr-apps.com/display/MAD/Development+Environment+Setup"
fi
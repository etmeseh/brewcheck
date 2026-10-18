#!/bin/sh
# brewcheck install/update:
#   curl -fsSL https://raw.githubusercontent.com/etmeseh/brewcheck/main/install.sh | sh
set -e

REPO="https://github.com/etmeseh/brewcheck.git"
DIR="$HOME/.brewcheck"
RC="$HOME/.zshrc"
LINE='[ -f "$HOME/.brewcheck/brewcheck.zsh" ] && source "$HOME/.brewcheck/brewcheck.zsh"'

if [ -d "$DIR/.git" ]; then
  echo "Updating: $DIR"
  git -C "$DIR" pull --ff-only --quiet
else
  echo "Downloading: $DIR"
  git clone --quiet --depth 1 "$REPO" "$DIR"
fi

if grep -qxF "$LINE" "$RC" 2>/dev/null; then
  echo "~/.zshrc already configured."
else
  printf '\n# brewcheck\n%s\n' "$LINE" >> "$RC"
  echo "Added to ~/.zshrc."
fi

echo "Done. Open a new terminal and run 'brewcheck'."

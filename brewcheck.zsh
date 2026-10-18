# brewcheck: Homebrew maintenance — upgrade formulae, report outdated casks,
# and check for background services/jobs owned by brew.
brewcheck() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found: https://brew.sh"
    return 1
  fi

  echo "== Formula upgrades (automatic, safe) =="
  if ! brew update; then
    echo "brew update failed (network?). Aborting."
    return 1
  fi
  brew upgrade --formula
  brew autoremove
  brew cleanup

  echo ""
  echo "== Outdated casks (decide manually) =="
  local casks
  casks=$(brew outdated --cask)
  if [ -n "$casks" ]; then
    echo "$casks"
    echo "To upgrade: brew upgrade --cask <name>"
  else
    echo "All up to date."
  fi

  echo ""
  echo "== brew doctor =="
  brew doctor

  echo ""
  echo "== Background brew services/jobs =="
  local found=0 out
  out=$(launchctl list | grep -i brew) && { echo "Loaded launchd jobs:"; echo "$out"; found=1; }
  out=$(ls ~/Library/LaunchAgents /Library/LaunchAgents /Library/LaunchDaemons 2>/dev/null | grep -i brew) \
    && { echo "plist files:"; echo "$out"; found=1; }
  out=$(brew services list 2>/dev/null | sed 1d) && [ -n "$out" ] \
    && { echo "brew services:"; echo "$out"; found=1; }
  [ "$found" -eq 0 ] && echo "Clean — no launchd jobs touching brew."
  return 0
}

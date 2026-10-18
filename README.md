# brewcheck

One-command Homebrew maintenance for macOS:

- Runs `brew update`, upgrades formulae, removes unused dependencies and old versions
- **Lists** outdated casks only (you decide what to upgrade)
- Runs `brew doctor`
- Shows any launchd jobs, plist files, or `brew services` owned by brew running in the background

## Install / update

```sh
curl -fsSL https://raw.githubusercontent.com/etmeseh/brewcheck/main/install.sh | sh
```

This clones the repo into `~/.brewcheck` and adds a single `source` line to `~/.zshrc`. Run the same command again to update.

## Usage

```sh
brewcheck
```

## Uninstall

```sh
rm -rf ~/.brewcheck
```

Then remove the `# brewcheck` line and the line below it from `~/.zshrc`.

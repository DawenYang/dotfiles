# dotfiles

Personal config files managed with [chezmoi](https://chezmoi.io).

## Structure

```
dot_config/
  zed/              → ~/.config/zed/
  Code/User/        → ~/.config/Code/User/
dot_ideavimrc       → ~/.ideavimrc
run_once_windows_setup.ps1   (creates AppData junctions on Windows)
```

On **Mac/Linux**, chezmoi places files directly into `~/.config/`.  
On **Windows**, apps read from `%APPDATA%\` — a one-time junction setup redirects those paths to `~/.config/` so everything stays in sync.

## First-time setup

### 1. Install chezmoi

```powershell
# Windows (winget)
winget install twpayne.chezmoi

# macOS
brew install chezmoi
```

### 2. Configure chezmoi source

```powershell
# Clone the repo wherever you like
git clone git@github.com:DawenYang/dotfiles.git ~/dotfiles

# Point chezmoi at it (one-time, per machine)
# Creates ~/.config/chezmoi/chezmoi.toml
echo 'sourceDir = "~/dotfiles"' > ~/.config/chezmoi/chezmoi.toml
```

> **Windows note:** `chezmoi init --source <path>` does NOT save the source path.
> You must write `chezmoi.toml` manually using flat TOML (no `[chezmoi]` section).

### 3. Apply

```powershell
chezmoi apply
```

This places all config files and runs `run_once_windows_setup.ps1` (Windows only),
which creates directory junctions from `%APPDATA%\<App>` → `~/.config/<app>`.

If an AppData directory already exists (app was previously installed), the script
will warn instead of overwriting. In that case:

1. Close the app
2. Delete the existing AppData directory
3. Re-run the junction script manually: `pwsh run_once_windows_setup.ps1`

## Daily sync

```powershell
# Pull latest from remote and apply locally
chezmoi update

# After editing a config file, push changes back
chezmoi re-add
chezmoi git -- add -A
chezmoi git -- commit -m "describe your change"
chezmoi git -- push
```

## Adding a new app (Windows)

Add an entry to `$Mappings` in `run_once_windows_setup.ps1`:

```powershell
@{
    Name   = "AppName"
    Source = "$env:APPDATA\AppName"        # where Windows looks
    Target = "$env:USERPROFILE\.config\appname"  # where chezmoi puts it
}
```

Then add the config files under `dot_config/appname/` in the repo.

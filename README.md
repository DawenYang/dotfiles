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

### Pull remote changes → local

```powershell
chezmoi update
```

### Push local changes → remote

chezmoi manages two locations:

- **Source** — the repo (`dot_config/zed/settings.json`, etc.)
- **Target** — the actual config files chezmoi places at `~/.config/`

When you edit a config file directly in the repo (source), just commit and push:

```powershell
chezmoi git -- add -A
chezmoi git -- commit -m "describe your change"
chezmoi git -- push
```

When an app (e.g. Zed) modifies its config via the GUI, it writes to the target
(`~/.config/zed/settings.json`). The source (repo) won't know about it until you
explicitly sync back:

```powershell
chezmoi re-add              # copies target → source (updates repo files)
chezmoi diff                # confirm what changed
chezmoi git -- add -A
chezmoi git -- commit -m "describe your change"
chezmoi git -- push
```

> **How the sync path works on Windows:**
> ```
> repo (source)  →[chezmoi apply]→  ~/.config/zed/  ←[junction]←  %APPDATA%\Zed\
> repo (source)  ←[chezmoi re-add]← ~/.config/zed/
> ```
> The junction makes `%APPDATA%\Zed` and `~/.config/zed/` the same directory.
> `chezmoi re-add` is still required to propagate app GUI changes back to the repo.

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

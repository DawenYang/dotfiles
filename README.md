# dotfiles

Personal config files managed with [chezmoi](https://chezmoi.io).

## Structure

```
dot_config/
  wezterm/          → ~/.config/wezterm/
  zed/              → ~/.config/zed/
  Code/User/        → ~/.config/Code/User/
  nushell/          → ~/.config/nushell/
dot_ideavimrc       → ~/.ideavimrc
.stylua.toml        → ~/.stylua.toml
run_once_windows_setup.ps1   (creates AppData junctions on Windows)
run_once_macos_setup.sh      (creates ~/Library symlink for nushell on macOS)
```

On **macOS/Linux**, chezmoi places files directly into `~/.config/`.  
On **Windows**, most apps read from `%APPDATA%\` — a one-time junction setup
redirects those paths to `~/.config/` so everything stays in sync.

**WezTerm** is the exception: it natively reads `~/.config/wezterm/` on all
platforms, so no junction is needed.

### Windows junction map

| App | Windows reads from | Chezmoi writes to |
|-----|--------------------|-------------------|
| Zed | `%APPDATA%\Zed` | `~/.config/zed` |
| VSCode | `%APPDATA%\Code\User` | `~/.config/Code/User` |
| Nushell | `%APPDATA%\nushell` | `~/.config/nushell` |
| WezTerm | *(reads `~/.config/wezterm` natively)* | `~/.config/wezterm` |

### macOS symlink

Nushell on macOS looks in `~/Library/Application Support/nushell` instead of
`~/.config/nushell`. The setup script creates a symlink so both point to the
same place.

## First-time setup

### 1. Install chezmoi

```powershell
# Windows
winget install twpayne.chezmoi

# macOS
brew install chezmoi
```

### 2. Install WezTerm

```powershell
# Windows
winget install wez.wezterm

# macOS
brew install --cask wezterm
```

### 3. Configure chezmoi source

```powershell
# Clone the repo
git clone git@github.com:DawenYang/dotfiles.git ~/dotfiles

# Point chezmoi at it (one-time, per machine)
# Windows — write chezmoi.toml manually (no [chezmoi] section wrapper):
echo 'sourceDir = "C:/Dev/dotfiles"' > ~/.config/chezmoi/chezmoi.toml

# macOS/Linux
echo 'sourceDir = "~/dotfiles"' > ~/.config/chezmoi/chezmoi.toml
```

> **Windows note:** `chezmoi init --source <path>` does NOT persist the source
> path. Write `chezmoi.toml` manually using flat TOML (no `[chezmoi]` section).

### 4. Apply

```powershell
chezmoi apply
```

This places all config files and runs the platform setup script once:
- **Windows** — `run_once_windows_setup.ps1`: creates `%APPDATA%` junctions for
  Zed, VSCode, and Nushell.
- **macOS** — `run_once_macos_setup.sh`: symlinks
  `~/Library/Application Support/nushell` → `~/.config/nushell`.

If an AppData directory already exists (app was previously installed), the
Windows script will warn instead of overwriting. In that case:

1. Close the app
2. Move its contents to the corresponding `~/.config/<app>` directory
3. Delete the original AppData directory
4. Re-run: `chezmoi apply`

## Daily sync

### Pull remote changes → local

```powershell
chezmoi update
```

### Push local changes → remote

chezmoi manages two locations:

- **Source** — the repo (`dot_config/zed/settings.json`, etc.)
- **Target** — the actual config files placed at `~/.config/`

When you edit a config file directly in the repo (source), commit and push:

```nushell
czpush "describe your change"
```

When an app (e.g. Zed) modifies its config via the GUI, it writes to the target.
The source (repo) won't know about it until you sync back:

```nushell
czr                       # copies target → source (re-adds changed files)
czd                       # preview what changed
czpush "describe your change"
```

> **How the sync path works on Windows:**
> ```
> repo (source)  →[chezmoi apply]→   ~/.config/zed/  ←[junction]←  %APPDATA%\Zed\
> repo (source)  ←[chezmoi re-add]←  ~/.config/zed/
> ```
> The junction makes `%APPDATA%\Zed` and `~/.config/zed/` the same directory.
> `chezmoi re-add` is still required to propagate GUI-driven changes back to the repo.

## Adding a new app

### Windows (needs junction)

Add an entry to `$Mappings` in `run_once_windows_setup.ps1`:

```powershell
@{
    Name   = "AppName"
    Source = "$env:APPDATA\AppName"               # where Windows looks
    Target = "$env:USERPROFILE\.config\appname"   # where chezmoi puts it
}
```

Then add the config files under `dot_config/appname/` in the repo.

### Any platform (no junction needed)

If the app natively respects `~/.config/<app>` (like WezTerm), just add the
config files under `dot_config/<appname>/` — no script changes required.

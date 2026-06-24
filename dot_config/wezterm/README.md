# WezTerm Keybindings

Leader key: `Ctrl+Space`

## General

| Key | Action |
|-----|--------|
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+W` | Close tab |
| `Ctrl+Tab` | Next tab |
| `Ctrl+Shift+Tab` | Previous tab |
| `Shift+F1`…`Shift+F24` | Jump to tab 1–24 |
| `Ctrl+Shift+N` | New window |
| `Alt+Enter` | Toggle fullscreen |
| `Ctrl+Shift+R` | Reload config |
| `Ctrl+Shift+P` | Command palette |
| `Shift+Alt+T` | Launcher (fuzzy search shell profiles) |

## Copy / Paste

| Key | Action |
|-----|--------|
| `Ctrl+Shift+C` | Copy to clipboard |
| `Ctrl+Shift+V` | Paste from clipboard |
| `Ctrl+Insert` | Copy to primary selection |
| `Ctrl+Shift+Insert` | Paste from primary selection |
| `Ctrl+Shift+Space` | Quick select |
| `Ctrl+Shift+U` | Character selector |

## Scrollback

| Key | Action |
|-----|--------|
| `PageUp` | Scroll page up |
| `PageDown` | Scroll page down |
| `Ctrl+Shift+K` | Clear scrollback |

## Panes

| Key | Action |
|-----|--------|
| `Ctrl+Shift+"` | Split vertical (new pane right) |
| `Ctrl+Shift+%` | Split horizontal (new pane below) |
| `Ctrl+Alt+H/J/K/L` | Move focus left/down/up/right |
| `Ctrl+Shift+Z` | Toggle pane zoom |
| `Ctrl+Shift+L` | Debug overlay |

## Modes

Modes are entered via the leader key (`Ctrl+Space`) followed by a letter.
Press `Esc` to exit any mode.

### Window Mode — `Leader` `w`

| Key | Action |
|-----|--------|
| `h/j/k/l` | Focus pane left/down/up/right |
| `Arrow keys` | Focus pane (arrow alternative) |
| `v` | Split vertical |
| `s` | Split horizontal |
| `p` | Pick pane |
| `x` | Swap pane with active |
| `o` | Toggle pane zoom |
| `q` | Close pane |
| `< / >` | Resize pane left/right |
| `+ / -` | Resize pane up/down |

### Copy Mode — `Leader` `c`

| Key | Action |
|-----|--------|
| `h/j/k/l` | Move cursor |
| `w/e/b` | Word forward / word end / word backward |
| `0 / $` | Line start / line end |
| `^ ` | Line content start |
| `g / G` | Scrollback top / bottom |
| `H/M/L` | Viewport top / middle / bottom |
| `v` | Select cell |
| `V` | Select line |
| `Ctrl+V` | Select block |
| `o / O` | Jump to other end of selection |
| `f/F/t/T` | Jump to character (forward/back) |
| `;` / `,` | Repeat jump / reverse jump |
| `Ctrl+D / Ctrl+U` | Scroll down / up half page |
| `y` | Copy selection and exit |
| `Esc` | Exit copy mode |

### Search Mode — `Leader` `s`

| Key | Action |
|-----|--------|
| `Ctrl+N / Ctrl+Shift+N` | Next / previous match |
| `Ctrl+R` | Cycle match type |
| `Ctrl+U` | Clear search pattern |
| `PageDown / PageUp` | Next / previous match page |
| `Esc` | Exit search mode |

### Font Mode — `Leader` `f`

| Key | Action |
|-----|--------|
| `+` | Increase font size |
| `-` | Decrease font size |
| `0` | Reset font size |
| `Esc` | Exit font mode |

### Pick Mode — `Leader` `p`

| Key | Action |
|-----|--------|
| `c` | Colorscheme picker |
| `f` | Font picker |
| `s` | Font size picker |
| `l` | Line height picker |
| `Esc` | Exit pick mode |

### Help Mode — `Leader` `h`

Displays all active keybindings inline in the status bar.

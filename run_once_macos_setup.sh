#!/bin/sh
# macOS: symlink nushell config from XDG path (~/.config/nushell) to
# Apple app support path (~/Library/Application Support/nushell), which
# is where nushell looks for config on macOS by default.
if [ "$(uname)" != "Darwin" ]; then
    exit 0
fi

APPDIR="$HOME/Library/Application Support/nushell"
XDGDIR="$HOME/.config/nushell"

# Already correctly symlinked — nothing to do
if [ -L "$APPDIR" ] && [ "$(readlink "$APPDIR")" = "$XDGDIR" ]; then
    exit 0
fi

# Back up existing directory if it's not already a symlink
if [ -d "$APPDIR" ] && [ ! -L "$APPDIR" ]; then
    mv "$APPDIR" "${APPDIR}.bak"
    echo "Backed up existing nushell config to ${APPDIR}.bak"
fi

ln -sf "$XDGDIR" "$APPDIR"
echo "Linked $APPDIR -> $XDGDIR"

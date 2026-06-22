#!/bin/sh
if [ "$(uname)" != "Darwin" ]; then
    exit 0
fi

# Symlink nushell config from XDG path (~/.config/nushell) to Apple app
# support path (~/Library/Application Support/nushell), which is where
# nushell looks for config on macOS by default.
APPDIR="$HOME/Library/Application Support/nushell"
XDGDIR="$HOME/.config/nushell"

if [ -L "$APPDIR" ] && [ "$(readlink "$APPDIR")" = "$XDGDIR" ]; then
    : # already correctly symlinked
elif [ -d "$APPDIR" ] && [ ! -L "$APPDIR" ]; then
    mv "$APPDIR" "${APPDIR}.bak"
    echo "Backed up existing nushell config to ${APPDIR}.bak"
    ln -sf "$XDGDIR" "$APPDIR"
    echo "Linked $APPDIR -> $XDGDIR"
else
    ln -sf "$XDGDIR" "$APPDIR"
    echo "Linked $APPDIR -> $XDGDIR"
fi

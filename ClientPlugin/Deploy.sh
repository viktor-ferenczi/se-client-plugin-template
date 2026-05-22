#!/usr/bin/env sh
set -eu

if [ "$#" -lt 2 ]; then
    echo "ERROR: Missing required parameters" >&2
    exit 1
fi

NAME=$1
SOURCE=${2%/}

if [ -f "$SOURCE/$NAME" ]; then
    SRCFILE=$SOURCE/$NAME
elif [ -f "$SOURCE" ]; then
    SRCFILE=$SOURCE
else
    echo "ERROR: Source not found: $SOURCE or $SOURCE/$NAME" >&2
    exit 1
fi

find_plugin_dir() {
    if [ -n "${PULSAR_LOCAL_DIR:-}" ]; then
        printf '%s\n' "$PULSAR_LOCAL_DIR"
        return
    fi

    if [ -n "${APPDATA:-}" ] && [ -d "$APPDATA/Pulsar/Legacy/Local" ]; then
        printf '%s\n' "$APPDATA/Pulsar/Legacy/Local"
        return
    fi

    for candidate in \
        "$HOME/.config/Pulsar/Legacy/Local" \
        "$HOME/.steam/steam/steamapps/compatdata/244850/pfx/drive_c/users/steamuser/AppData/Roaming/Pulsar/Legacy/Local" \
        "$HOME/.local/share/Steam/steamapps/compatdata/244850/pfx/drive_c/users/steamuser/AppData/Roaming/Pulsar/Legacy/Local" \
        "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/compatdata/244850/pfx/drive_c/users/steamuser/AppData/Roaming/Pulsar/Legacy/Local"
    do
        if [ -d "$candidate" ]; then
            printf '%s\n' "$candidate"
            return
        fi
    done

    printf '%s\n' "$HOME/.config/Pulsar/Legacy/Local"
}

PLUGIN_DIR=$(find_plugin_dir)

if [ ! -d "$PLUGIN_DIR" ]; then
    echo "Missing Local plugin folder: $PLUGIN_DIR" >&2
    echo "Set PULSAR_LOCAL_DIR to your Pulsar Legacy/Local folder if it is elsewhere." >&2
    exit 2
fi

echo "Copying \"$SRCFILE\" to \"$PLUGIN_DIR/\""
cp -f "$SRCFILE" "$PLUGIN_DIR/"

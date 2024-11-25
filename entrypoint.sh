#!/bin/sh

if [ ! -f "/app/.filebrowser.json" ]; then
    config=$(cat <<EOF
{
    "port": 80,
    "baseURL": "",
    "address": "",
    "log": "stdout",
    "database": "/app/database/database.db",
    "root": "/srv"
}
EOF
)
    echo "\"/app/.filebrowser.json\" not found! Start completing the file." ; \
    echo "$config" > /app/.filebrowser.json && \
    echo "Done."
else
    if [ ! -s "/app/.filebrowser.json" ]; then
        config=$(cat <<EOF
{
    "port": 80,
    "baseURL": "",
    "address": "",
    "log": "stdout",
    "database": "/app/database/database.db",
    "root": "/srv"
}
EOF
)
        echo "\"/app/.filebrowser.json\" is empty! Start completing the file." ; \
        echo "$config" > /app/.filebrowser.json && \
        echo "Done."
    fi
fi

chown -R ${PUID}:${PGID} /app

umask ${UMASK}

cd /app && exec su-exec ${PUID}:${PGID} ./filebrowser "$@"
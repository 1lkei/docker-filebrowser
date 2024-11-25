#!/bin/sh

json_content=$(cat <<EOF
{
    "port": 80,
    "baseURL": "",
    "address": "",
    "log": "stdout",
    "database": "/app/database.db",
    "root": "/srv"
}
EOF
)

if [ ! -f "/app/.filebrowser.json" ]; then
    echo "\"/app/.filebrowser.json\" Not Found! Start completing the file." ; \
    echo "$json_content" > /app/.filebrowser.json && \
    echo "Done."
fi

chown -R ${PUID}:${PGID} /app

umask ${UMASK}

exec su-exec ${PUID}:${PGID} /app/filebrowser "$@"
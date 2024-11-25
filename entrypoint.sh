#!/bin/sh

if [ ! -f "/app/.filebrowser.json" ]; then
    json_content=$(cat <<EOF
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
    echo "$json_content" > /app/.filebrowser.json && \
    echo "Done."
else
    if [ ! -s "/app/.filebrowser.json" ]; then
        json_content=$(cat <<EOF
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
        echo "$json_content" > /app/.filebrowser.json && \
        echo "Done."
    fi
fi

chown -R ${PUID}:${PGID} /app

umask ${UMASK}

exec su-exec ${PUID}:${PGID} /app/filebrowser "$@"
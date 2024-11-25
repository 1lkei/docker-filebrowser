#!/bin/sh

if [ ! -f "/.filebrowser.json" ]; then
    echo "/.filebrowser.json Not Found! Start Download"
    curl -L -o /.filebrowser.json https://github.com/filebrowser/filebrowser/raw/refs/heads/master/docker_config.json && \
    echo "Download Done."
fi

chown -R ${PUID}:${PGID} /filebrowser /.filebrowser.json

umask ${UMASK}

exec su-exec ${PUID}:${PGID} /filebrowser "$@"
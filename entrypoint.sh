#!/bin/sh

chown -R ${PUID}:${PGID} /filebrowser

umask ${UMASK}

exec su-exec ${PUID}:${PGID} /filebrowser "$@"
FROM alpine:latest AS builder
ARG VERSION
RUN apk --update add ca-certificates curl tar && \
    cd /opt && \
    curl -L -o linux-amd64-filebrowser.tar.gz https://github.com/filebrowser/filebrowser/releases/download/$VERSION/linux-amd64-filebrowser.tar.gz && \
    tar -xzf linux-amd64-filebrowser.tar.gz && \
    rm linux-amd64-filebrowser.tar.gz

FROM alpine:latest
RUN apk update && \
    apk add --no-cache ca-certificates \
                     mailcap \
                     curl \
                     jq \
                     bash \
                     su-exec && \
    rm -rf /var/cache/apk/*

WORKDIR /app

COPY --from=builder /opt/filebrowser /app/
COPY ./entrypoint.sh /entrypoint.sh

RUN curl -L -o /healthcheck.sh https://github.com/filebrowser/filebrowser/raw/refs/tags/$VERSION/healthcheck.sh && \
    # curl -L -o /.filebrowser.json https://github.com/filebrowser/filebrowser/raw/refs/tags/$VERSION/docker_config.json && \
    # curl -L -o /entrypoint.sh https://github.com/1lkei/docker-filebrowser/raw/refs/heads/main/entrypoint.sh && \
    chmod +x /healthcheck.sh && \
    chmod +x /entrypoint.sh

HEALTHCHECK --start-period=2s --interval=5s --timeout=3s \
    CMD /healthcheck.sh || exit 1

VOLUME /srv
EXPOSE 80
ENV PUID=0 PGID=0 UMASK=022

ENTRYPOINT [ "/entrypoint.sh" ]
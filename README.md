# docker-filebrowser

### 自动构建filebrowser

`注意需要先创建一个空.filebrowser.json文件`
```
docker run -d \
    --name filebrowser \
    --restart unless-stopped \
    -e PUID=1000 \
    -e PGID=1000 \
    -e UMASK=022 \
    -p 80:80 \
    -v /app/database:/app/database \
    -v /app/.filebrowser.json:/app/.filebrowser.json \
    1lkei/filebrowser:latest
```
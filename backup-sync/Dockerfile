FROM alpine:latest

RUN apk add --no-cache --upgrade rclone fuse3 rclone

COPY overlay /

VOLUME /mnt

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh  

ENTRYPOINT ["sh", "/entrypoint.sh"]

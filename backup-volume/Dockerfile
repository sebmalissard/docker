FROM alpine:latest

RUN apk add --no-cache --upgrade docker-cli

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh  

ENTRYPOINT ["/entrypoint.sh"]

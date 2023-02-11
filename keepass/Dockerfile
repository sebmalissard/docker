FROM alpine:latest

RUN apk add --no-cache --upgrade \
    openssh \
    rssh

RUN adduser -D -h /home/keepass -s /usr/bin/rssh keepass

RUN passwd -u keepass

COPY overlay /

VOLUME /ssh

EXPOSE 22

CMD ["/usr/sbin/sshd","-D","-E","/var/log/sshd"]

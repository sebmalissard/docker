FROM alpine:latest

RUN apk add --no-cache --upgrade \
    nginx

COPY website.conf /etc/nginx/http.d/default.conf

RUN mkdir -p /var/www/html

EXPOSE 80

USER nginx
CMD ["nginx", "-g", "daemon off;"]

FROM alpine:3.14

# Update
RUN apk update && apk upgrade --no-cache
RUN apk add --no-cache nginx openssl
RUN adduser -D www && chown -R www:www /var/lib/nginx

# ==========================================================================================
#                                    Install SSL
# ==========================================================================================
RUN mkdir -p /etc/ssl/certs && mkdir -p /etc/ssl/private \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=inception' \
	-keyout /etc/ssl/private/inception.key -out /etc/ssl/certs/inception.crt

EXPOSE 80 443

ENTRYPOINT nginx -g 'pid /tmp/nginx.pid; daemon off;' 

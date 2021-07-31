FROM alpine:3.14

# Update system
RUN apk update && apk upgrade --no-cache

# Install packages
RUN apk add --no-cache mysql mysql-client

ADD ./entrypoint.sh entrypoint.sh
ADD ./init.sql init.sql
ADD ./my.cnf /etc/mysql/my.cnf

EXPOSE 3306

ENTRYPOINT [ "./entrypoint.sh" ]
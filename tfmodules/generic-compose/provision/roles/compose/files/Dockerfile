FROM alpine:latest

RUN apk add --no-cache wireguard-tools

COPY ./entrypoint.sh /tmp/entrypoint.sh

ENTRYPOINT [ "/tmp/entrypoint.sh" ]
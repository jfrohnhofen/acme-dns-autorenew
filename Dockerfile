FROM alpine:latest

WORKDIR /root

RUN apk add lego

ADD run-lego /root/
ADD entrypoint.sh /root/

RUN echo "*/3 * * * * /root/run-lego renew" >> /etc/crontabs/root

ADD secret /run/secrets/test

ENV CA_SERVER=https://acme-v02.api.letsencrypt.org/directory

ENTRYPOINT ["/root/entrypoint.sh"]

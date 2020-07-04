FROM alpine:latest

WORKDIR /root

RUN apk add lego
RUN echo "0 0 * * 0 /root/run-lego renew" >> /etc/crontabs/root

ADD run-lego /root/
ADD entrypoint.sh /root/

ENV CA_SERVER=https://acme-v02.api.letsencrypt.org/directory

ENTRYPOINT ["/root/entrypoint.sh"]

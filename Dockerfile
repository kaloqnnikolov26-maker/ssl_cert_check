FROM alpine:3.19

RUN apk add --no-cache bash openssl coreutils

WORKDIR /app
COPY check_certs.sh websites.conf ./

RUN chmod +x check_certs.sh

CMD ["./check_certs.sh"]

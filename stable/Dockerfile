FROM alpine

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL \
    org.opencontainers.image.vendor="The Goofball - goofball222@gmail.com" \
    org.opencontainers.image.url="https://github.com/goofball222/freeradius" \
    org.opencontainers.image.title="FreeRadius Docker Container" \
    org.opencontainers.image.description="FreeRadius Docker Container" \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.source="https://github.com/goofball222/freeradius" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.licenses="Apache-2.0"

ENV \
    DEBUG=false \
    PGID=999 \
    PUID=999 \
    RADIUSD_OPTS=

COPY root /

RUN \
    set -x \
    && delgroup ping \
    && addgroup -g $PGID radius \
    && adduser -D -G radius -u $PUID radius \
    && chown -R root:radius /etc/raddb/*.conf /etc/raddb/mods-config/files \
    && apk add -q --no-cache \
        bash freeradius freeradius-radclient tzdata \
#   Alpine FreeRadius unused mods Kitchen Sink list, for future reference 2018-08-19.
#       freeradius-checkrad freeradius-doc freeradius-eap freeradius-krb5 freeradius-ldap \
#       freeradius-lib freeradius-mssql freeradius-mysql freeradius-pam freeradius-perl \
#       freeradius-postgresql freeradius-python freeradius-redis freeradius-rest freeradius-sql \
#       freeradius-sqlite freeradius-unixodbc \
    && rm -rf /tmp/* /var/cache/apk/*

EXPOSE 1812/udp 1813/udp

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["radiusd"]

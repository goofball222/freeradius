FROM alpine

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL \
    org.label-schema.vendor="The Goofball - goofball222@gmail.com" \
    org.label-schema.url="https://github.com/goofball222/freeradius" \
    org.label-schema.name="FreeRadius Docker Container" \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-url="https://github.com/goofball222/freeradius.git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.license="Apache-2.0" \
    org.label-schema.schema-version="1.0"

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

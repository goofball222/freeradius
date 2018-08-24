#!/usr/bin/env bash

# Init script for Alpine FreeRadius Docker container
# License: Apache-2.0
# Github: https://github.com/goofball222/radiusd.git
SCRIPT_VERSION="1.0.1"
# Last updated date: 2018-08-24

set -Eeuo pipefail

if [ "${DEBUG}" == 'true' ];
    then
        set -x
fi

log() {
    echo "$(date -u +%FT$(nmeter -d0 '%3t' | head -n1)) <docker-entrypoint> $*"
}

log "INFO - Script version ${SCRIPT_VERSION}"

LOGFILE=/var/log/radius/radius.log
RADIUSD=/usr/sbin/radiusd

RADIUSD_OPTS="${RADIUSD_OPTS}"

radiusd_setup() {
    log "INFO - Insuring freeradius setup for container"

    touch /var/log/radius/radius.log

    RADIUSD_OPTS="${RADIUSD_OPTS}"
}

exit_handler() {
    log "INFO - Exit signal received, commencing shutdown"
    pkill -15 -f ${RADIUSD}
    for i in `seq 0 20`;
        do
            [ -z "$(pgrep -f ${RADIUSD})" ] && break
            # kill it with fire if it hasn't stopped itself after 20 seconds
            [ $i -gt 19 ] && pkill -9 -f ${RADIUSD} || true
            sleep 1
    done
    log "INFO - Shutdown complete. Nothing more to see here. Have a nice day!"
    log "INFO - Exit with status code ${?}"
    exit ${?};
}

# Wait indefinitely on log tail until killed
idle_handler() {
    while true
    do
        tail -f ${LOGFILE} & wait ${!}
    done
}

trap 'kill ${!}; exit_handler' SIGHUP SIGINT SIGQUIT SIGTERM

if [[ "${@}" == 'radiusd' ]];
    then
        radiusd_setup
        log "EXEC - ${RADIUSD} ${RADIUSD_OPTS}"
        exec 0<&-
        exec ${RADIUSD} ${RADIUSD_OPTS} &
        idle_handler
    else
        log "EXEC - ${@}"
        exec "${@}"
fi

# Script should never make it here, but just in case exit with a generic error code if it does
exit 1;

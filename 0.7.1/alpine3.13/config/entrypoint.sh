#!/bin/sh
## Exit script if any command fails (non-zero status)
set -e

## TimeZone (default is Europe/Prague)
if [ "${TIME_ZONE}" = "UTC" ]; then
    rm /etc/localtime
fi

## Make the entrypoint a pass through that then runs the docker command (redirect all input arguments)
exec "$@"
